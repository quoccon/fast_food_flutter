import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/address.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final Dio dio = Dio();

  void getAddress(String userId) async {
    try {
      final response = await dio
          .post("http://10.0.2.2:3000/getAddress", data: {'userId': userId});
      if (response.statusCode == 200) {
        final dynamic jsonData = response.data;
        if (jsonData is List) {
          // Dữ liệu trả về là một danh sách
          final List<Address> addressList =
              jsonData.map((json) => Address.fromJson(json)).toList();
          emit(AddressSuccess(address: addressList));
        } else {
          throw Exception(
              "Dữ liệu trả về không phải là một danh sách hoặc một đối tượng JSON.");
        }
      } else {
        throw Exception("Lỗi lấy danh sách địa chỉ: ${response.statusMessage}");
      }
    } catch (e) {
      print('Đã có lỗi khi lấy danh sách địa chỉ: $e');
      emit(AddressError(error: "Đã có lỗi khi lấy danh sách địa chỉ: $e"));
    }
  }

  Future<void> addAddress(String userId, String name, int phonenum,
      String address, String dictrict, String city) async {
    try {
      final response = await dio.post("http://10.0.2.2:3000/addAddress", data: {
        'userId': userId,
        'name': name,
        'phonenum': phonenum,
        'address': address,
        'district': dictrict,
        'city': city
      });

      if (response.statusCode == 200) {
        final List<Address> listAddress = (response.data as List)
            .map((json) => Address.fromJson(json))
            .toList();
        emit(AddressSuccess(address: listAddress));
      } else {
        emit(AddressError(
            error: "Không thêm được địa chỉ ${response.statusMessage}"));
      }
    } catch (e) {
      print('Đã có lỗi khi thêm địa chỉ $e');
    }
  }
}
