import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/domain/models/NotificationAction.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';

abstract class NotificationRepository {
  Future<Either<List<NotificationModel>, String>> getAllNotificationByEmpId(
      String empId);

  Future<bool> markAsReadNotification(int notificationId, int markAsRead);

  Future<Either<List<NotificationAction>, String>> getAllNotificationAction();

  Future<bool> createNotification(NotificationModel notificationModel);
}
