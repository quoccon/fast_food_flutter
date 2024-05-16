import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:food_client/models/category.dart';
import 'package:food_client/models/product.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  Dio dio = new Dio();

  Future<void> getCat() async {
    try {
      final reponse = await dio.get("http://10.0.2.2:3000/getCat");
      if (reponse.statusCode == 200) {
        final List<Category> dataCat = (reponse.data as List)
            .map((json) => Category.fromJson(json))
            .toList();
        print('dataCat == $dataCat');
        emit(CatSuccess(category: dataCat));
      } else {
        emit(CatError(
            error: "Không lấy được danh sách cat ${reponse.statusMessage}"));
      }
    } catch (e) {
      emit(CatError(error: "Đã có lỗi khi lấy danh sách cat : $e"));
    }
  }


}
