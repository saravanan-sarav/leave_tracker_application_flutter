import 'package:flutter/material.dart';

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

  RequestData(
      this.id,
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
      this.requestStatus);
}

List<RequestData> applicationDetails = [
  RequestData(
      1,
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
      findUsingRequestStatusId(3)),
  RequestData(
      2,
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
      findUsingRequestStatusId(2)),
  RequestData(
      2,
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
      findUsingRequestStatusId(1)),
];

List<RequestData>? getSortedRequestData(int? value) {
  print(value);
  if (value==0) {
    applicationDetails.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return applicationDetails;
  }
  if (value! > 0) {
    final filteredData = applicationDetails
        .where((element) => element.requestStatus?.id == value).toList();
    filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return filteredData;
  }
  return null;
}
