import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/domain/models/request_type.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';

import 'request.dart';

const String requestStatusTableName = "request_status";
const String requestStatusColumnId = "id";
const String requestStatusColumnRequestStatus = "request_status_type";

class RequestStatus {
  final int id;
  final String requestStatus;

  RequestStatus(this.id, this.requestStatus);

  factory RequestStatus.fromJson(Map<String, dynamic> json) {
    return RequestStatus(
      json[requestStatusColumnId] as int,
      json[requestStatusColumnRequestStatus] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      requestStatusColumnId: id,
      requestStatusColumnRequestStatus: requestStatus,
    };
  }
}

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
      DateTime(2023,10,09),
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
