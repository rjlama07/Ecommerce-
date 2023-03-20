import 'package:ecommerce/models/users.dart';

class UserState {
  final bool isError;
  final bool isSuccess;
  final String error;
  final bool isLoading;
  final List<Users> users;
  UserState(
      {required this.error,
      required this.users,
      required this.isError,
      required this.isLoading,
      required this.isSuccess});

  UserState copyWith({
    bool? isError,
    bool? isSuccess,
    String? error,
    bool? isLoading,
    List<Users>? users,
  }) {
    return UserState(
        error: error ?? this.error,
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        users: users ?? this.users);
  }
}
