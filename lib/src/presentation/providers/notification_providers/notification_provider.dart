import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/notification_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/notification_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:leave_tracker_application/src/presentation/state_management/notification_badge_state.dart';

import '../../../domain/repositories/notification_repository.dart';
import '../user_providers/current_logged_in_provider.dart';

final notificationDataSourceProvider =
    Provider((ref) => NotificationDataSource());

final notificationRepositoryProvider = Provider((ref) {
  final notificationDataSource = ref.read(notificationDataSourceProvider);
  return NotificationRepositoryImpl(notificationDataSource);
});

class NotificationsNotifier extends StateNotifier<List<NotificationModel>> {
  final NotificationRepository notificationRepository;
  final StateNotifierProviderRef ref;

  NotificationsNotifier(super.state, this.notificationRepository, this.ref);

  Future<void> getAllNotifications() async {
    String empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    final notificationListOrNotFound =
        await notificationRepository.getAllNotificationByEmpId(empId);
    notificationListOrNotFound.fold((l) => state = l, (r) => null);
    ref.read(notificationBadgeProvider.notifier).updateNotificationCount();
  }

  int getUnReadNotificationCount() {
    int count = 0;
    for (NotificationModel notify in state) {
      if (notify.markAsRead == false) {
        count++;
      }
    }
    return count;
  }

  Future<bool> markAsReadNotification(
      int notificationId, bool markAsRead) async {
    bool result = false;
    if (markAsRead) {
      result = await notificationRepository.markAsReadNotification(
          notificationId, 0);
    } else {
      result = await notificationRepository.markAsReadNotification(
          notificationId, 1);
    }
    if (result) {
      for (NotificationModel res in state) {
        if (res.id == notificationId) {
          res.markAsRead = !res.markAsRead;
          res.markAsReadAt = DateTime.now();
        }
      }
    }
    return result;
  }

  Future<int> createNotification(NotificationModel notificationModel) async {
    int result =
        await notificationRepository.createNotification(notificationModel);
    notificationModel.id = result;
    if (notificationModel.empId ==
        ref
            .read(currentLoggedInUserDetailsProvider.notifier)
            .getState()
            .empId) {
      state.add(notificationModel);
    }
    ref.read(notificationBadgeProvider.notifier).updateNotificationCount();
    return result;
  }

  void clearNotifications() {
    state = [];
  }
}

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<NotificationModel>>(
        (ref) {
  final notificationRepository = ref.read(notificationRepositoryProvider);
  return NotificationsNotifier([], notificationRepository, ref);
});
