import 'package:leave_tracker_application/src/data/database/dbHelper.dart';
import 'package:leave_tracker_application/src/domain/models/NotificationAction.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/exceptions/dataNotFoundException.dart';

class NotificationDataSource {
  Future<List<NotificationModel>> getAllNotificationByEmpId(
      String empId) async {
    print("Notification Source called");
    List<NotificationModel> notificationList = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          "SELECT * FROM $notificationTableName WHERE $notificationColumnEmpId=$empId");
      for (var res in result) {
        notificationList.add(NotificationModel.fromJson(res));
      }
    }
    return notificationList;
  }

  Future<List<NotificationAction>> getNotificationAction() async {
    List<NotificationAction> notificationActionList = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result =
          await dbClient.rawQuery("SELECT * FROM $notificationActionTableName");
      for (var res in result) {
        notificationActionList.add(NotificationAction.fromJson(res));
      }
    }
    return notificationActionList;
  }

  Future<bool?> notificationMarkAsReadByNotificationId(
      int id, int markAsRead) async {
    Database? dbClient = DatabaseHelper.database;
    String dateTime = DateTime.now().toIso8601String();
    if (dbClient != null) {
      int result = await dbClient.rawUpdate(
          '''UPDATE $notificationTableName SET $notificationColumnMarkAsRead=$markAsRead, $notificationColumnMarkAsReadAt="$dateTime" WHERE $notificationColumnId=$id''');
      List<Map<String, dynamic>> result1 = await dbClient.rawQuery(
          "SELECT * FROM $notificationTableName WHERE $notificationColumnId=$id");
      for (var res in result1) {
        print(res.toString());
      }
      print(result);
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

  Future<bool> createNotification(NotificationModel notificationModel) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      int result = await dbClient.insert(
          notificationTableName, notificationModel.toJson());
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    }
    throw DataNotFoundException("No Data Found in request Data");
  }
}
