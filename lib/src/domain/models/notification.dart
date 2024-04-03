import 'dart:core';


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


