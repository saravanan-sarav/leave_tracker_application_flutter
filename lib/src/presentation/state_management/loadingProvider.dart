import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier(super.state);

  void startLoading() {
    state = true;
  }

  void endLoading() {
    Future.delayed(const Duration(seconds: 1), () {
      state = false;
    });
  }
}

final loadingProvider = StateNotifierProvider((ref) => LoadingNotifier(false));
