import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/resources/api_constants.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class CrudServices {
  static final cloudinary =
      CloudinaryPublic('CLOUD_NAME', 'UPLOAD_PRESET', cache: false);
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
    required String productName,
    required String prodctDetail,
    required String imageUrl,
    required int price,
    required String publicId,
    required XFile image,
  }) async {
    try {
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image));
      final response = await dio.post(addProduct, data: {
        "product_name": productName,
        "product_details": prodctDetail,
        "price": price,
        "imageUrl": imageUrl,
        "public_id": publicId,
      });
      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    } on CloudinaryException catch (e) {
      return left("${e.message}");
    }
  }
}
