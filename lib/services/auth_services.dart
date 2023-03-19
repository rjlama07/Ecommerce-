import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/resources/api_constants.dart';

class AuthServices {
  static Dio dio = Dio();
  static Future<Either<String, bool>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio
          .post(userLoginUrl, data: {"email": email, "password": password});
      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    }
  }

  static Future<Either<String, bool>> userSignUp({
    required String email,
    required String password,
    required String full_name,
  }) async {
    try {
      final response = await dio.post(userSignupUrl,
          data: {"email": email, "password": password, "full_name": full_name});
      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    }
  }
}
