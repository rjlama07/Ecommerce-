class CurdState {
  final bool isError;
  final bool isSuccess;
  final String error;
  final bool isLoading;
  CurdState(
      {required this.error,
      required this.isError,
      required this.isLoading,
      required this.isSuccess});

  CurdState copyWith({
    bool? isError,
    bool? isSuccess,
    String? error,
    bool? isLoading,
  }) {
    return CurdState(
        error: error ?? this.error,
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}
