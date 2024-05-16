import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final Dio dio = Dio();

  Future<void> addToCart(String userId, String productId, int count,
      double total, Function() callback) async {
    try {
      final response = await dio.post("http://10.0.2.2:3000/addToCart", data: {
        'userId': userId,
        'productId': productId,
        'quantity': count,
        'total_order': total
      });

      if (response.statusCode == 200) {
        final List<Cart> dataCart =
            (response.data as List).map((json) => Cart.fromJson(json)).toList();
        emit(CartSuccess(cart: dataCart));
        callback.call();
      } else {
        emit(CartError(error: "Không thể thêm vào giỏ hàng"));
      }
    } catch (e) {
      print('Đã có lỗi == $e');
    }
  }

  Future<List<Cart>> getCart(String userId) async {
    try {
      final response = await dio
          .post("http://10.0.2.2:3000/getCart", data: {'userId': userId});
      if (response.statusCode == 200) {
        final List<Cart> listData =
            (response.data as List).map((json) => Cart.fromJson(json)).toList();
        emit(CartSuccess(cart: listData));
        return listData;
      } else {
        throw Exception(
            "Lỗi lấy danh sách giỏ hàng : ${response.statusMessage}");
      }
    } catch (e) {
      print('Đã có lỗi lấy danh sách giỏ hàng : $e');
      throw e;
    }
  }
}
