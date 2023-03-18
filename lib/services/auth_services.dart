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
          .post(userSignupUrl, data: {"email": email, "password": password});
      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    }
  }
}
