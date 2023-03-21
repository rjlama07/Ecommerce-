import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/resources/api_constants.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class CrudServices {
  static final cloudinary =
      CloudinaryPublic('dt2g4qvd9', 'clavstws', cache: false);
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

  static Future<Either<String, bool>> productCreate({
    required String productName,
    required String prodctDetail,
    required int price,
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
        "imageUrl": res.secureUrl,
        "public_id": res.publicId,
      });
      return right(true);
    } on DioError catch (err) {
      return left("${err.message}");
    } on CloudinaryException catch (e) {
      return left("${e.message}");
    }
  }
}
