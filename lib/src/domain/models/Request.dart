import 'package:flutter/material.dart';

import '../../utils/constants/TimeParser.dart';

const String requestDataTableName = "request_data";
const String requestDataColumnId = "id";
const String requestDataColumnEmpId = "emp_id";
const String requestDataColumnRequestTitle = "request_title";
const String requestDataColumnRequestTypeId = "request_type_id";
const String requestDataColumnProjectName = "project_name";
const String requestDataColumnTeamId = "team_id";
const String requestDataColumnFromDate = "from_date";
const String requestDataColumnToDate = "to_date";
const String requestDataColumnFromTime = "from_time";
const String requestDataColumnToTime = "to_time";
const String requestDataColumnReason = "reason";
const String requestDataColumnAppliedDate = "applied_date";
const String requestDataColumnRequestStatusId = "request_status_id";
const String requestDataColumnApprovedAt = "approved_at";
const String requestDataColumnReportTo = "report_to";

class RequestData {
  int id;
  String empId;
  String requestTitle;
  int requestTypeId;
  String projectName;
  String teamId;
  DateTime fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String reason;
  DateTime appliedDate;
  int requestStatusId;
  DateTime? approvedAt;
  String reportTo;

  RequestData(
    this.id,
    this.empId,
    this.requestTitle,
    this.requestTypeId,
    this.projectName,
    this.teamId,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.reason,
    this.appliedDate,
    this.requestStatusId,
    this.approvedAt,
    this.reportTo,
  );

  Map<String, dynamic> toJson() {
    return {
      requestDataColumnEmpId: empId,
      requestDataColumnRequestTitle: requestTitle,
      requestDataColumnRequestTypeId: requestTypeId,
      requestDataColumnProjectName: projectName,
      requestDataColumnTeamId: teamId,
      requestDataColumnFromDate: fromDate.toIso8601String(),
      requestDataColumnToDate: toDate?.toIso8601String(),
      requestDataColumnFromTime: fromTime.toString(),
      requestDataColumnToTime: toTime.toString(),
      requestDataColumnReason: reason,
      requestDataColumnAppliedDate: appliedDate.toIso8601String(),
      requestDataColumnRequestStatusId: requestStatusId,
      requestDataColumnApprovedAt: approvedAt?.toIso8601String(),
      requestDataColumnReportTo: reportTo,
    };
  }

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      json[requestDataColumnId],
      json[requestDataColumnEmpId],
      json[requestDataColumnRequestTitle],
      json[requestDataColumnRequestTypeId],
      json[requestDataColumnProjectName],
      json[requestDataColumnTeamId],
      DateTime.parse(json[requestDataColumnFromDate]),
      json[requestDataColumnToDate] != null
          ? DateTime.parse(json[requestDataColumnToDate])
          : null,
      json[requestDataColumnFromTime] != null
          ? stringToTimeOfDay(json[requestDataColumnFromTime])
          : null,
      json[requestDataColumnToTime] != null
          ? stringToTimeOfDay(json[requestDataColumnToTime])
          : null,
      json[requestDataColumnReason],
      DateTime.parse(json[requestDataColumnAppliedDate]),
      json[requestDataColumnRequestStatusId],
      json[requestDataColumnApprovedAt] != null
          ? DateTime.parse(json[requestDataColumnApprovedAt])
          : null,
      json[requestDataColumnReportTo],
    );
  }
}
