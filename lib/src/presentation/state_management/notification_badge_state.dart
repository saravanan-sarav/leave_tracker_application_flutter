import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/notification_providers/notification_provider.dart';

class NotificationBadgeCountNotifier extends StateNotifier<int> {
  final StateNotifierProviderRef ref;

  NotificationBadgeCountNotifier(super.state, this.ref);

  void increaseCount() {
    state++;
  }

  void decreaseCount() {
    state--;
  }

  int getState() {
    return state;
  }

  void updateNotificationCount() {
    state =
        ref.read(notificationsProvider.notifier).getUnReadNotificationCount();
  }
}

final notificationBadgeProvider =
    StateNotifierProvider<NotificationBadgeCountNotifier, int>((ref) =>
        NotificationBadgeCountNotifier(
            ref
                .read(notificationsProvider.notifier)
                .getUnReadNotificationCount(),
            ref));
