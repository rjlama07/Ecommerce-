import 'package:ecommerce/models/curd_state.dart';
import 'package:ecommerce/services/curd_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CurdProvider extends StateNotifier<CurdState> {
  CurdProvider(super.state);
  Future<void> productCreate({
    required String productName,
    required String prodctDetail,
    required int price,
    required XFile image,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await CrudServices.productCreate(
        image: image,
        prodctDetail: prodctDetail,
        price: price,
        productName: productName);
    response.fold((l) {
      state = state.copyWith(
          error: l, isError: true, isSuccess: false, isLoading: false);
    }, (r) {
      state = state.copyWith(
          error: "", isError: false, isSuccess: true, isLoading: false);
    });
  }
}

final curdProvider = StateNotifierProvider<CurdProvider, CurdState>((ref) =>
    CurdProvider(CurdState(
        error: "", isError: false, isLoading: false, isSuccess: false)));
