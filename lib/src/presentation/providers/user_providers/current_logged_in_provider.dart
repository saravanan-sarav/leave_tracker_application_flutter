import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/user_provider.dart';

import '../../../domain/models/user.dart';

class CurrentLoggedInUserDetailsNotifier extends StateNotifier<UserData> {
  CurrentLoggedInUserDetailsNotifier(super.state);

  UserData getState() {
    return state;
  }

  void setState(UserData userData) {
    state = userData;
  }

  Future<bool> removeLoggedInDetails() async {
    state = UserData(
        0, "", "", "", "", DateTime.now(), "", "", DateTime.now(), 2, "");
    return true;
  }
}

final currentLoggedInUserDetailsProvider =
    StateNotifierProvider<CurrentLoggedInUserDetailsNotifier, UserData>((ref) =>
        CurrentLoggedInUserDetailsNotifier(
            ref.read(authUserDetailsProvider.notifier).getAuthUserDetails()));
