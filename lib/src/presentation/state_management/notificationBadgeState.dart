import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/currentLoggedInUser.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';

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
}

final notificationBadgeProvider =
    StateNotifierProvider<NotificationBadgeCountNotifier, int>((ref) =>
        NotificationBadgeCountNotifier(
            getUnreadNotificationCount(currentLoggedInUser.empId)));
