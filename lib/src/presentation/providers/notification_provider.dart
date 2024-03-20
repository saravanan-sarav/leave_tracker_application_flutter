import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/notification_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/notification_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/notification_action.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/notification_badge_state.dart';

import '../../domain/repositories/notificationRepository.dart';

final notificationDataSourceProvider =
    Provider((ref) => NotificationDataSource());

final notificationRepositoryProvider = Provider((ref) {
  final notificationDataSource = ref.read(notificationDataSourceProvider);
  return NotificationRepositoryImpl(notificationDataSource);
});

class NotificationsNotifier extends StateNotifier<List<NotificationModel>> {
  final NotificationRepository notificationRepository;

  NotificationsNotifier(super.state, this.notificationRepository);

  List<NotificationModel> getNotifications() {
    state.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return state;
  }

  Future<void> getAllNotifications(WidgetRef ref) async {
    int count = 0;
    String empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    final notificationListOrNotFound =
        await notificationRepository.getAllNotificationByEmpId(empId);
    notificationListOrNotFound.fold((l) => state = l, (r) => null);
    for (NotificationModel notify in state) {
      if (notify.markAsRead == false) {
        count++;
      }
    }
    ref.read(notificationBadgeProvider.notifier).setNotificationCount(count);
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

  Future<bool> createNotification(NotificationModel notificationModel) async {
    bool result =
        await notificationRepository.createNotification(notificationModel);
    return result;
  }
}

final notificationsProvider = StateNotifierProvider((ref) {
  final notificationRepository = ref.read(notificationRepositoryProvider);
  return NotificationsNotifier([], notificationRepository);
});

class NotificationActionNotifier
    extends StateNotifier<List<NotificationAction>> {
  final NotificationRepository notificationRepository;

  NotificationActionNotifier(super.state, this.notificationRepository);

  String getNotificationAction(int id) {
    return state.firstWhere((element) => element.id == id).actions;
  }

  Future<void> getNotificationActions() async {
    final notificationActionListOrNotFound =
        await notificationRepository.getAllNotificationAction();
    notificationActionListOrNotFound.fold((l) => state = l, (r) => null);
  }
}

final notificationActionProvider = StateNotifierProvider((ref) {
  final notificationRepository = ref.read(notificationRepositoryProvider);
  return NotificationActionNotifier([], notificationRepository);
});
