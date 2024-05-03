import 'package:flutter/material.dart';

import '../../domain/models/history_tabs.dart';
import '../../domain/models/holiday.dart';
import '../../domain/models/holiday_type.dart';
import '../../domain/models/notification.dart';
import '../../domain/models/notification_action.dart';
import '../../domain/models/remaining_leave.dart';
import '../../domain/models/request.dart';
import '../../domain/models/request_status.dart';
import '../../domain/models/request_type.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_remaining_leave.dart';

List<HistoryTab> historyTabs = [
  HistoryTab(1, "All"),
  HistoryTab(2, "Approved"),
  HistoryTab(3, "Pending"),
  HistoryTab(4, "Rejected"),
];

final List<Holiday> holidays = [
  Holiday(1, DateTime(2024, 1, 1), 'New Year Day', 1),
  Holiday(2, DateTime(2024, 1, 26), 'Republic Day', 1),
  Holiday(3, DateTime(2024, 1, 15), 'Pongal', 1),
  Holiday(4, DateTime(2024, 5, 1), 'May Day', 1),
  Holiday(5, DateTime(2024, 7, 15), 'Independence Day', 1),
  Holiday(6, DateTime(2024, 10, 2), 'Gandhi Jayanthi', 1),
  Holiday(7, DateTime(2024, 10, 11), 'Ayutha Pooja', 1),
  Holiday(8, DateTime(2024, 10, 31), 'Diwali', 1),
  Holiday(9, DateTime(2024, 12, 25), 'Christmas', 1),
  Holiday(10, DateTime(2024, 3, 29), 'Good Friday', 2),
  Holiday(11, DateTime(2024, 4, 9), 'Telugu New Year', 2),
  Holiday(12, DateTime(2024, 4, 11), 'Ramzan', 2),
  Holiday(13, DateTime(2024, 6, 17), 'Bakrid', 2),
  Holiday(14, DateTime(2024, 7, 17), 'Muharram', 2),
  Holiday(15, DateTime(2024, 8, 26), 'Krishna Jayanthi', 2),
  Holiday(16, DateTime(2024, 9, 16), 'Milad-un-Nabi', 2),
  // Add more holidays...
];

List<HolidayType> holidayTypeList = [
  HolidayType(1, "Holiday"),
  HolidayType(2, "Restricted Holiday")
];

List<NotificationModel> notificationList = [
  NotificationModel(1, "1001", "Saravanan S", 1, 1, "I am Suffering From Fever",
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
  NotificationModel(5, "1001", "Saravanan S", 5, 1, "Comensatory Off",
      DateTime(2023, 10, 03), true, DateTime(2023, 10, 04)),
];

List<NotificationAction> notificationActionList = [
  NotificationAction(1, "Created a Request"),
  NotificationAction(2, "Request Accepted"),
  NotificationAction(3, "Request Pending"),
  NotificationAction(4, "Request Rejected"),
];

List<RemainingLeave> remainingLeaves = [
  RemainingLeave(1, 2, 1),
  RemainingLeave(2, 2, 2),
  RemainingLeave(3, 3, 3),
  RemainingLeave(4, 3, 4),
  RemainingLeave(5, 6, 5),
  RemainingLeave(6, 15, 6),
];

List<RequestStatus> requestStatusList = [
  RequestStatus(1, "Accepted"),
  RequestStatus(2, "Pending"),
  RequestStatus(3, "Rejected")
];

List<RequestData> applicationDetails = [
  RequestData(
      1,
      "1001",
      "Sick Leave",
      3,
      "CIBC",
      "102",
      DateTime.now(),
      DateTime.now(),
      null,
      null,
      "I am suffering from severe fever.",
      DateTime.now(),
      3,
      DateTime(2024, 03, 01),
      "101"),
  RequestData(
      2,
      "1001",
      "Compensatory Leave",
      1,
      "Sen benth",
      "152",
      DateTime.now(),
      DateTime.now(),
      null,
      null,
      "I worked last week sunday.",
      DateTime.now(),
      1,
      DateTime(2023, 10, 12),
      "101"),
  RequestData(
      3,
      "1001",
      "Permission",
      5,
      "Sen benth",
      "152",
      DateTime.now(),
      null,
      TimeOfDay.now(),
      TimeOfDay.now(),
      "I worked last week sunday.",
      DateTime.now(),
      1,
      DateTime(2023, 10, 09),
      "1"),
  RequestData(
      4,
      "101",
      "Permission",
      5,
      "Sen benth",
      "152",
      DateTime.now(),
      null,
      TimeOfDay.now(),
      TimeOfDay.now(),
      "I worked last week sunday.",
      DateTime.now(),
      2,
      null,
      "1"),
  RequestData(
      5,
      "101",
      "Permission",
      5,
      "Sen benth",
      "152",
      DateTime.now(),
      null,
      TimeOfDay.now(),
      TimeOfDay.now(),
      "I worked last week sunday.",
      DateTime.now(),
      2,
      null,
      "1"),
];

final List<RequestType> requestTypes = [
  RequestType(1, "Compensatory Off"),
  RequestType(2, "Cyclone Leave"),
  RequestType(3, "Leave Without Pay"),
  RequestType(4, "Leave with Pay"),
  RequestType(5, "Permission"),
  RequestType(6, "Work From Home")
];

List<UserData> userDetails = [
  UserData(
      1,
      "1001",
      "Saravanan S",
      "Banking",
      "Intern",
      DateTime(2023, 9, 11),
      "saravanan@kumaran.com",
      "Saravanan@123",
      DateTime(2001, 10, 04),
      2003,
      "101"),
  UserData(
      2,
      "1002",
      "Gnanesh",
      "Banking",
      "Intern",
      DateTime(2023, 9, 11),
      "gnanesh@kumaran.com",
      "Gnanesh@123",
      DateTime(2002, 02, 10),
      2003,
      "101"),
  UserData(
      3,
      "101",
      "SaravanaKumar",
      "Banking",
      "Project Manager",
      DateTime(2020, 4, 11),
      "saravanankumar@kumaran.com",
      "Skumar@123",
      DateTime(1996, 01, 10),
      2003,
      "102"),
  UserData(
      4,
      "102",
      "Lohith Hariharan",
      "Banking",
      "Senior Project Manager",
      DateTime(2021, 9, 11),
      "lohith@kumaran.com",
      "lohith@123",
      DateTime(1995, 01, 04),
      2003,
      "1"),
  UserData(5, "1", "Admin", "Banking", "Admin", DateTime(2021, 9, 11), "admin@",
      "1234", DateTime(1995, 01, 04), 2003, "1"),
];

List<UserRemainingLeave> userRemainingLeaveData = [
  UserRemainingLeave(1, "1001", 2, 1),
  UserRemainingLeave(2, "1001", 4, 0),
  UserRemainingLeave(3, "1001", 3, 2),
  UserRemainingLeave(4, "1001", 1, 2),
  UserRemainingLeave(5, "1001", 5, 3),
  UserRemainingLeave(6, "1001", 6, 8),
  UserRemainingLeave(1, "101", 2, 0),
  UserRemainingLeave(2, "101", 4, 0),
  UserRemainingLeave(3, "101", 3, 1),
  UserRemainingLeave(4, "101", 1, 2),
  UserRemainingLeave(5, "101", 5, 2),
  UserRemainingLeave(6, "101", 6, 4),
  UserRemainingLeave(1, "1002", 2, 0),
  UserRemainingLeave(2, "1002", 4, 0),
  UserRemainingLeave(3, "1002", 3, 0),
  UserRemainingLeave(4, "1002", 1, 0),
  UserRemainingLeave(5, "1002", 5, 0),
  UserRemainingLeave(6, "1002", 6, 0),
  UserRemainingLeave(1, "102", 2, 0),
  UserRemainingLeave(2, "102", 4, 0),
  UserRemainingLeave(3, "102", 3, 0),
  UserRemainingLeave(4, "102", 1, 0),
  UserRemainingLeave(5, "102", 5, 0),
  UserRemainingLeave(6, "102", 6, 0),
];
