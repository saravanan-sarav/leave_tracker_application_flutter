import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationBadgeCountNotifier extends StateNotifier<int> {
  NotificationBadgeCountNotifier(super.state);

  void increaseCount() {
    state++;
  }

  void decreaseCount() {
    state--;
  }

  int getState() {
    return state;
  }

  void setNotificationCount(int value) {
    state = value;
  }
}

final notificationBadgeProvider =
    StateNotifierProvider<NotificationBadgeCountNotifier, int>(
        (ref) => NotificationBadgeCountNotifier(0));
