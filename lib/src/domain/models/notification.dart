import 'dart:core';

import 'package:intl/intl.dart';

const String notificationTableName = "notification";
const String notificationColumnId = "id";
const String notificationColumnEmpId = "emp_id";
const String notificationColumnName = "name";
const String notificationColumnRequestTypeId = "request_type_id";
const String notificationColumnActionId = "action_id";
const String notificationColumnReason = "reason";
const String notificationColumnCreatedAt = "created_at";
const String notificationColumnMarkAsRead = "mark_as_read";
const String notificationColumnMarkAsReadAt = "mark_as_read_at";

class NotificationModel {
  final int id;
  final String empId;
  final String name;
  final int requestTypeId;
  final int actionId;
  final String reason;
  final DateTime createdAt;
  bool markAsRead;
  DateTime? markAsReadAt;

  NotificationModel(
    this.id,
    this.empId,
    this.name,
    this.requestTypeId,
    this.actionId,
    this.reason,
    this.createdAt,
    this.markAsRead,
    this.markAsReadAt,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      json[notificationColumnId],
      json[notificationColumnEmpId],
      json[notificationColumnName],
      json[notificationColumnRequestTypeId],
      json[notificationColumnActionId],
      json[notificationColumnReason],
      DateTime.parse(json[notificationColumnCreatedAt]),
      json[notificationColumnMarkAsRead] == 1 ? true : false,
      json[notificationColumnMarkAsReadAt] != null
          ? DateTime.parse(json[notificationColumnMarkAsReadAt])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      notificationColumnEmpId: empId,
      notificationColumnName: name,
      notificationColumnRequestTypeId: requestTypeId,
      notificationColumnActionId: actionId,
      notificationColumnReason: reason,
      notificationColumnCreatedAt: createdAt.toString(),
      notificationColumnMarkAsRead: markAsRead ? 1 : 0,
      notificationColumnMarkAsReadAt: markAsReadAt?.toString(),
    };
  }
}

List<NotificationModel> notificationList = [
  NotificationModel(1, "1001", "Saravanan", 1, 1, "I am Suffering From Fever",
      DateTime(2023, 10, 03), true, DateTime(2023, 10, 04)),
  NotificationModel(
      2,
      "1001",
      "Saravanakumar",
      3,
      2,
      "I am going to take compensatory Leave",
      DateTime(2023, 10, 03),
      true,
      DateTime(2023, 10, 04)),
  NotificationModel(3, "1001", "Saravanakumar", 2, 4, "I am going to temple",
      DateTime(2023, 10, 03), true, DateTime(2023, 10, 04)),
  NotificationModel(
      4,
      "1001",
      "Saravanakumar",
      4,
      2,
      "I am Not feeling well so going to take rest..",
      DateTime(2023, 10, 03),
      true,
      DateTime(2023, 10, 04)),
  NotificationModel(5, "1001", "Sick Leave", 5, 1, "Comensatory Off",
      DateTime(2023, 10, 03), true, DateTime(2023, 10, 04)),
];

