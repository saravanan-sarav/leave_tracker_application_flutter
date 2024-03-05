import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/domain/models/currentLoggedInUser.dart';
import 'package:leave_tracker_application/src/domain/models/requestType.dart';
import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';

class RequestStatus {
  final int id;
  final String requestStatus;

  RequestStatus(this.id, this.requestStatus);
}

List<RequestStatus> requestStatusList = [
  RequestStatus(1, "Accepted"),
  RequestStatus(2, "Pending"),
  RequestStatus(3, "Rejected")
];

RequestStatus? findUsingRequestStatusId(int id) {
  try {
    return requestStatusList.firstWhere((element) => element.id == id);
  } catch (e) {
    return null;
  }
}

class RequestData {
  int id;
  String empId;
  String requestTitle;
  int requestType;
  String projectName;
  int teamId;
  DateTime fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String reason;
  DateTime appliedDate;
  RequestStatus? requestStatus;
  DateTime? approvedAt;
  final String reportTo;

  RequestData(
      this.id,
      this.empId,
      this.requestTitle,
      this.requestType,
      this.projectName,
      this.teamId,
      this.fromDate,
      this.toDate,
      this.reason,
      this.fromTime,
      this.toTime,
      this.appliedDate,
      this.requestStatus,
      this.approvedAt,
      this.reportTo);
}

List<RequestData> applicationDetails = [
  RequestData(
      1,
      "1001",
      "Sick Leave",
      3,
      "CIBC",
      102,
      DateTime.now(),
      DateTime.now(),
      "I am suffering from severe fever.",
      null,
      null,
      DateTime.now(),
      findUsingRequestStatusId(3),
      DateTime(2024, 03, 01),
      "101"),
  RequestData(
      2,
      "1001",
      "Compensatory Leave",
      1,
      "Sen benth",
      152,
      DateTime.now(),
      DateTime.now(),
      "I worked last week sunday.",
      null,
      null,
      DateTime.now(),
      findUsingRequestStatusId(1),
      DateTime(2023, 10, 12),
      "101"),
  RequestData(
      3,
      "101",
      "Permission",
      5,
      "Sen benth",
      152,
      DateTime.now(),
      null,
      "I worked last week sunday.",
      TimeOfDay.now(),
      TimeOfDay.now(),
      DateTime.now(),
      findUsingRequestStatusId(2),
      null,
      "1"),
  RequestData(
      3,
      "101",
      "Permission",
      5,
      "Sen benth",
      152,
      DateTime.now(),
      null,
      "I worked last week sunday.",
      TimeOfDay.now(),
      TimeOfDay.now(),
      DateTime.now(),
      findUsingRequestStatusId(2),
      null,
      "1"),
  RequestData(
      3,
      "101",
      "Permission",
      5,
      "Sen benth",
      152,
      DateTime.now(),
      null,
      "I worked last week sunday.",
      TimeOfDay.now(),
      TimeOfDay.now(),
      DateTime.now(),
      findUsingRequestStatusId(2),
      null,
      "1"),
];

List<RequestData>? getSortedCreatedByMeRequestData(String empId, int? value) {
  if (value == 0) {
    final filteredData =
        applicationDetails.where((element) => element.empId == empId).toList();
    filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return filteredData;
  }
  if (value! > 0) {
    final filteredData = applicationDetails
        .where((element) =>
            element.empId == empId && element.requestStatus?.id == value)
        .toList();
    filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return filteredData;
  }
  return null;
}

List<RequestData>? getSortedSentToMeRequestData(String empId, int? value) {
  if (value == 0) {
    final filteredData = applicationDetails
        .where((element) => element.reportTo == empId)
        .toList();
    filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return filteredData;
  }
  if (value! > 0) {
    final filteredData = applicationDetails
        .where((element) =>
            element.reportTo == empId && element.requestStatus?.id == value)
        .toList();
    filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return filteredData;
  }
  return null;
}

int countApplicationsByEmpId(String empId) {
  int count = 0;
  for (var data in applicationDetails) {
    if (data.empId == empId) {
      count++;
    }
  }
  return count;
}

int countApplicationsSentToMeByEmpId(String empId) {
  int count = 0;
  for (var data in applicationDetails) {
    if (data.reportTo == empId) {
      count++;
    }
  }
  return count;
}

class RequestDescriptionDetail {
  final String empId;
  final String empName;
  final String empDomain;
  final String empDesignation;
  final int requestTypeId;
  final String requestType;
  final DateTime fromDate;
  final DateTime? toDate;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final DateTime createdAt;
  final DateTime? approvedAt;
  final int requestStatusId;
  final String requestStatus;
  final String reason;
  final String reportingToUserName;
  final String reportingToUserDomain;
  final String reportingToUserDesignation;

  RequestDescriptionDetail(
      this.empId,
      this.empName,
      this.empDomain,
      this.empDesignation,
      this.requestTypeId,
      this.requestType,
      this.fromDate,
      this.toDate,
      this.fromTime,
      this.toTime,
      this.createdAt,
      this.approvedAt,
      this.requestStatusId,
      this.requestStatus,
      this.reason,
      this.reportingToUserName,
      this.reportingToUserDomain,
      this.reportingToUserDesignation);
}

RequestDescriptionDetail getRequestDetailsByRequestId(int id) {
  RequestData requestData =
      applicationDetails.firstWhere((element) => element.id == id);

  UserData user =
      userDetails.firstWhere((element) => element.empId == requestData.empId);

  UserData reportingTo =
      userDetails.firstWhere((element) => element.empId == user.reportingTo);

  RequestType requestType = requestTypes
      .firstWhere((element) => element.id == requestData.requestType);

  return RequestDescriptionDetail(
      user.empId,
      user.name,
      user.Domain,
      user.designation,
      requestType.id,
      requestType.type,
      requestData.fromDate,
      (requestData.toDate),
      (requestData.fromTime),
      (requestData.toTime),
      requestData.appliedDate,
      requestData.approvedAt,
      requestData.requestStatus!.id,
      requestData.requestStatus!.requestStatus,
      requestData.reason,
      reportingTo.name,
      reportingTo.Domain,
      reportingTo.designation);
}

bool requestStatusChange(int requestId, int statusId) {
  for (RequestData r in applicationDetails) {
    if (r.id == requestId && r.reportTo == currentLoggedInUser.empId) {
      RequestStatus requestStatus =
          requestStatusList.firstWhere((element) => element.id == statusId);
      r.requestStatus = requestStatus;
      r.approvedAt = DateTime.now();
      return true;
    }
  }
  return false;
}
