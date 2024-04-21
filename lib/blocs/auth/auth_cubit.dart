import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:food_client/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final Dio dio = new Dio();

  Future<void> login(String emailController, String passwordController,
      Function(User) callback) async {
    try {
      final email = emailController;
      final password = passwordController;

      final response = await dio.post("http://10.0.2.2:3000/api/login",
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        emit(Auththenticated(user: user));
        callback(user);
      } else {
        emit(AuthError(error: "Đăng nhập thất bại"));
      }
    } catch (e) {
      emit(AuthError(error: "Đã có lỗi khi xử lý yêu cầu đăng nhập"));
    }
  }

  Future<void> register(String usernameController, String emailController,
      phoneController, passwordController, Function(User) callback) async {
    try {
      final username = usernameController;
      final email = emailController;
      final phone = phoneController;
      final password = passwordController;

      final response = await dio.post("http://10.0.2.2:3000/api/register", data: {
        'username': username,
        'email': email,
        'phone': phone,
        'password': password
      });

      if(response.statusCode == 200){
        User user = response.data;
        emit(Auththenticated(user: user));
        callback(user);
      }else{
        emit(AuthError(error: "Đăng ký thất bại"));
      }
    } catch (e) {
      emit(AuthError(
          error: "Đã có lỗi khi xử lý yêu cầu đăng ký người dùng : $e"));
    }
  }
}
