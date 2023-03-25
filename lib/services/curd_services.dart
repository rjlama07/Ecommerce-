import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/resources/api_constants.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product_model.dart';

final productShow = FutureProvider((ref) => CrudServices.getProduct());

class CrudServices {
  static final cloudinary =
      CloudinaryPublic('dt2g4qvd9', 'clavstws', cache: false);
  static Dio dio = Dio();
  static Future<Either<String, bool>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      await dio
          .post(userLoginUrl, data: {"email": email, "password": password});

      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    }
  }

  static Future<List<Product>> getProduct() async {
    try {
      final response = await dio.get(baseUrl);
      return (response.data as List).map((e) => Product.fromJson(e)).toList();
    } on DioError catch (err) {
      throw Exception(err);
    }
  }

  static Future<Either<String, bool>> productCreate({
    required String productName,
    required String prodctDetail,
    required int price,
    required XFile image,
    required String token,
  }) async {
    try {
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image));
      print(token);
      await dio.post(addProduct,
          data: {
            "product_name": productName,
            "product_detail": prodctDetail,
            "price": price,
            "imageUrl": res.secureUrl,
            "public_id": res.publicId,
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));

      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    } on CloudinaryException catch (e) {
      return left("${e.message}");
    }
  }
}
