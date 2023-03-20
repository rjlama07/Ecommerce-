import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/resources/api_constants.dart';
import 'package:hive/hive.dart';

class AuthServices {
  static Dio dio = Dio();
  static Future<Either<String, Users>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio
          .post(userLoginUrl, data: {"email": email, "password": password});
      final user = Users.fromJson(response.data);
      final box = Hive.box<Users>("users");
      box.add(user);
      return right(user);
    } on DioError catch (err) {
      return left("${err.message}");
    }
  }

  static Future<Either<String, bool>> userSignUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await dio.post(userSignupUrl,
          data: {"email": email, "password": password, "full_name": fullName});
      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    }
  }
}
