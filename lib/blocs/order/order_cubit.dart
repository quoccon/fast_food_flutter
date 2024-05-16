import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:food_client/models/order.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  final Dio dio = Dio();

  Future<void> addOrder(
      String username,
      double? total,
      String? city,
      String? district,
      String? address,
      String? name,
      String? phonenum,
      String? paymentMethod,
      List<Item> items) async {

    try{
      final response = await dio.post("http://10.0.2.2:3000/addOrder",data: {
        'username':username,
        'total':total,
        "city":city,
        'district':district,
        'address':address,
        'name':name,
        'phonenum':phonenum,
        'paymentMethod':paymentMethod,
        'items':items.map((item) => item.toJson()).toList(),
      });

      if(response.statusCode == 200){
        final List<Order> order = (response.data as List).map((json) => Order.fromJson(json)).toList();
        emit(OrderSuccess(order: order));
      }else{
        emit(OrderError(error: "Đã có lỗi khi đặt hàng : ${response.statusMessage}"));
      }
    }catch(e){
      print('Đã có lỗi khi đặt hàng: $e');
    }
  }
}
