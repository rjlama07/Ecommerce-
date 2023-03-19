import 'package:ecommerce/models/curd_state.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthProvider, CurdState>((ref) =>
    AuthProvider(CurdState(
        error: "", isError: false, isLoading: false, isSuccess: false)));

class AuthProvider extends StateNotifier<CurdState> {
  AuthProvider(super.state);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    final response =
        await AuthServices.userLogin(email: email, password: password);
    return response.fold(
        (l) => {
              state = state.copyWith(
                  isError: true, isSuccess: false, isLoading: false, error: l)
            },
        (r) => {
              state = state.copyWith(
                  isError: false, isSuccess: true, isLoading: false, error: "")
            });
  }

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String fullName}) async {
    state = state.copyWith(isLoading: true);
    final response = await AuthServices.userSignUp(
        email: email, password: password, full_name: fullName);
    return response.fold(
        (l) => {
              state = state.copyWith(
                  isError: true, isSuccess: false, isLoading: false, error: l)
            },
        (r) => {
              state = state.copyWith(
                  isError: false, isSuccess: true, isLoading: false, error: "")
            });
  }
}
