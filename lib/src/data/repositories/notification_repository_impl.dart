import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasource/local/notification_data_source.dart';
import 'package:leave_tracker_application/src/domain/models/notification_action.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:leave_tracker_application/src/domain/repositories/notificationRepository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource notificationDataSource;

  NotificationRepositoryImpl(this.notificationDataSource);

  @override
  Future<Either<List<NotificationModel>, String>> getAllNotificationByEmpId(
      String empId) async {
    List<NotificationModel> result =
        await notificationDataSource.getAllNotificationByEmpId(empId);
    if (result.isNotEmpty) {
      return Left(result);
    } else {
      return const Right("No Notifications");
    }
  }

  @override
  Future<bool> markAsReadNotification(
      int notificationId, int markAsRead) async {
    bool? result = await notificationDataSource
        .notificationMarkAsReadByNotificationId(notificationId, markAsRead);
    if (result!) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either<List<NotificationAction>, String>>
      getAllNotificationAction() async {
    List<NotificationAction> result =
        await notificationDataSource.getNotificationAction();
    if (result.isNotEmpty) {
      return Left(result);
    } else {
      return const Right("No Notifications");
    }
  }

  @override
  Future<bool> createNotification(NotificationModel notificationModel) async {
    bool result =
        await notificationDataSource.createNotification(notificationModel);
    return result;
  }
}
