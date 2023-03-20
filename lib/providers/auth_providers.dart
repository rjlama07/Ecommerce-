import 'package:ecommerce/main.dart';
import 'package:ecommerce/models/user_state.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/users.dart';

class AuthProvider extends StateNotifier<UserState> {
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
                  isError: true,
                  isSuccess: false,
                  isLoading: false,
                  error: l,
                  users: [])
            },
        (r) => {
              state = state.copyWith(
                  isError: false,
                  isSuccess: true,
                  isLoading: false,
                  error: "",
                  users: [r])
            });
  }

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String fullName}) async {
    state = state.copyWith(isLoading: true);
    final response = await AuthServices.userSignUp(
        email: email, password: password, fullName: fullName);
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

  Future<void> userLogout() async {
    state = state.copyWith(
        isError: false,
        isSuccess: true,
        isLoading: false,
        error: "",
        users: []);
    final box = Hive.box<Users>("users");
    box.clear();
  }
}

final authProvider = StateNotifierProvider<AuthProvider, UserState>((ref) =>
    AuthProvider(UserState(
        error: "",
        isError: false,
        isLoading: false,
        isSuccess: false,
        users: ref.watch(box))));
