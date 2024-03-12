import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/utils/constants/TimeParser.dart';

class RequestDescriptionDetail {
  final int id;
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
  DateTime? approvedAt;
  int requestStatusId;
  final String requestStatus;
  final String reason;
  final String reportingToUserName;
  final String reportingToUserDomain;
  final String reportingToUserDesignation;

  RequestDescriptionDetail(
      this.id,
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

  factory RequestDescriptionDetail.fromJson(Map<String, dynamic> json) {
    return RequestDescriptionDetail(
      json['id'],
      json['emp_id'],
      json['name'],
      json['domain'],
      json['designation'],
      json['request_type_id'],
      json['request_type'],
      DateTime.parse(json['from_date']),
      json['to_date'] != null ? DateTime.parse(json['to_date']) : null,
      json['from_time'] != null ? stringToTimeOfDay(json['from_time']) : null,
      json['to_time'] != null ? stringToTimeOfDay(json['to_time']) : null,
      DateTime.parse(json['applied_date']),
      json['approved_at'] != null ? DateTime.parse(json['approved_at']) : null,
      json['request_status_id'],
      json['request_status'],
      json['reason'],
      json['reporting_to_name'],
      json['reporting_to_domain'],
      json['reporting_to_designation'],
    );
  }
}
