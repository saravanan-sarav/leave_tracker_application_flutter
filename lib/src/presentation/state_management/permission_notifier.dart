import 'package:flutter_riverpod/flutter_riverpod.dart';


class PermissionNotifier extends StateNotifier<bool> {
  PermissionNotifier(super.state);

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

final permissionNotifyProvider =
    StateNotifierProvider<PermissionNotifier, bool>(
        (ref) => PermissionNotifier(false));
