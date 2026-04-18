import 'package:flutter_riverpod/flutter_riverpod.dart';

class OthersNotifier extends StateNotifier<bool> {
  OthersNotifier(super.state);

  bool updateState() {
    return state = true;
  }

  void setState() {
    state = false;
  }

  bool getState() {
    return state;
  }
}

final othersNotifyProvider =
    StateNotifierProvider<OthersNotifier, bool>((ref) => OthersNotifier(false));
