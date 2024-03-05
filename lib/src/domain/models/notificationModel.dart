import 'dart:core';

import 'package:intl/intl.dart';

class NotificationModel {
  final int id;
  final String empId;
  final String name;
  final String requestTitle;
  final String reasons;
  final DateTime createdAt;
  bool markAsRead;

  NotificationModel(this.id, this.empId, this.name, this.requestTitle,
      this.reasons, this.createdAt, this.markAsRead);
}

List<NotificationModel> notificationList = [
  NotificationModel(
      1,
      "1001",
      "Saravanan",
      "Sick Leave",
      "Suffering from severe head Ache and Fever",
      parseCustomDateTime("20-10-2023T12:40"),
      false),
  NotificationModel(1, "1001", "Saravanan", "Casual Leave",
      "Going for Temple visit", parseCustomDateTime("22-11-2023T19:10"), true),
  NotificationModel(
      1,
      "1001",
      "Saravanan",
      "Casual Leave",
      "Casual Leave on Monday.",
      parseCustomDateTime("12-02-2024T08:40"),
      false),
  NotificationModel(
      1,
      "1001",
      "Saravanan",
      "Leave for Marriage function",
      "I am going to marriage function",
      parseCustomDateTime("19-02-2024T03:40"),
      false),
  NotificationModel(
      1,
      "101",
      "Saravanan",
      "Medical Leave",
      "Going for full body Check Up",
      parseCustomDateTime("26-02-2024T08:40"),
      false),
  NotificationModel(
      1,
      "101",
      "Saravanan",
      "Compensatory Leave",
      "I have worked last friday So I am taking Compensate leave today.",
      parseCustomDateTime("25-02-2024T07:40"),
      false),
];

String formatTimeAgo(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} day(s) ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour(s) ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute(s) ago';
  } else {
    return 'Just now';
  }
}

DateTime parseCustomDateTime(String inputDateTimeString) {
  // Parse the custom date-time string
  List<String> dateTimeParts = inputDateTimeString.split("T");
  String datePart = dateTimeParts[0];
  String timePart = dateTimeParts[1];

  List<String> dateParts = datePart.split("-");
  List<String> timeParts = timePart.split(":");

  int year = int.parse(dateParts[2]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[0]);
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  DateTime finalParser = DateTime(year, month, day, hour, minute);
  return finalParser;
}

String formatDateTime(DateTime dateTime) {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  return dateFormat.format(dateTime);
}

List<NotificationModel>? getSortedNotifications(String empId) {
  try {
    // Filter the notificationList based on empId
    List<NotificationModel> filteredList = notificationList
        .where((notification) => notification.empId == empId)
        .toList();

    // Sort the filteredList based on appliedDate
    filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return filteredList;
  } catch (e) {
    return null;
  }
}

int getUnreadNotificationCount(String empId) {
  final filteredList = notificationList
      .where((element) => element.empId == empId && !element.markAsRead);
  return filteredList.length;
}
