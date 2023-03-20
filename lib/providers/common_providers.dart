import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonProvider =
    StateNotifierProvider<CommonProvider, bool>((ref) => CommonProvider(true));

class CommonProvider extends StateNotifier<bool> {
  CommonProvider(super.state);
  void togle() {
    state = !state;
  }
}
