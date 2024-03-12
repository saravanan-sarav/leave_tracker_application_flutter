import 'package:leave_tracker_application/src/domain/models/remainingLeave.dart';
import 'package:leave_tracker_application/src/domain/models/requestType.dart';

import '../userRemainingLeave.dart';

class RemainingLeaveResponse {
  final int id;
  final int requestTypeId;
  final String requestType;
  final int allocatedLeave;
  final int bookedCount;

  RemainingLeaveResponse(
    this.id,
    this.requestTypeId,
    this.requestType,
    this.allocatedLeave,
    this.bookedCount,
  );

  factory RemainingLeaveResponse.fromJson(Map<String, dynamic> map) {
    return RemainingLeaveResponse(
        map[remainingLeaveColumnId],
        map["request_type_id"],
        map[requestTypeColumnType],
        map[remainingLeaveColumnAllocatedLeave],
        map[userRemainingLeaveColumnBookedCount]);
  }
}
