import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../../models/product.dart';
import 'package:dio/dio.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  final Dio dio = Dio();

  Future<void> getProduct() async {
    try {
      final response = await dio.get("http://10.0.2.2:3000/getProduct");
      if (response.statusCode == 200) {
        final List<Product> dataProduct = (response.data as List)
            .map((json) => Product.fromJson(json))
            .toList();
        emit(ProductSuccess(product: dataProduct));
      } else {
        emit(ProductError(error: "Không lấy được danh sách sản phẩm"));
      }
    } catch (e) {
      emit(ProductError(error: "Đã có lỗi xảy ra : $e"));
      print('Đã có lỗi xảy ra : $e');
    }
  }

  Future<List<Product>> getProductByCategory(String category) async {
    try {
      final response = await dio.post("http://10.0.2.2:3000/getProByCat",
          data: {'category': category});
      if (response.statusCode == 200) {
        final List<Product> productList = (response.data as List).map((json) => Product.fromJson(json)).toList();

        emit(ProductSuccess(product: productList));

      }else{
        emit(ProductError(error: "Lỗi lấy danh sách ${response.statusMessage}"));
      }
    } catch (e) {
      emit(ProductError(error: "Lỗi khi lấy danh sách sản phẩm $e"));
    }
    return [];
  }

  Future<void> addWithList (String userId, String productId,Function() callback)async{
    try{
      final response = await dio.post("http://10.0.2.2:3000/addToWithList",data: {"userId":userId,"productId":productId});
      if(response.statusCode == 200){
        final List<Product> productList = (response.data as List).map((json) => Product.fromJson(json)).toList();
        emit(ProductSuccess(product: productList));
        callback.call();
      }else{
        emit(ProductError(error: "Lỗi khi thêm sản phẩm vào danh sách yêu thích"));
      }
    }catch(e){
      emit(ProductError(error: "Đã có lỗi khi thêm sản phẩm vào danh sách yêu thích $e"));
    }
  }


}
