const String userRemainingLeaveTableName = "user_remaining_leave";
const String userRemainingLeaveColumnId = "id";
const String userRemainingLeaveColumnEmpId = "emp_id";
const String userRemainingLeaveColumnRequestTypeId = "request_type_id";
const String userRemainingLeaveColumnBookedCount = "booked_count";

class UserRemainingLeave {
  final int id;
  final String empId;
  final int requestTypeId;
  final int bookedCount;

  UserRemainingLeave(
    this.id,
    this.empId,
    this.requestTypeId,
    this.bookedCount,
  );

  factory UserRemainingLeave.fromJson(Map<String, dynamic> json) {
    return UserRemainingLeave(
      json[userRemainingLeaveColumnId],
      json[userRemainingLeaveColumnEmpId],
      json[userRemainingLeaveColumnRequestTypeId],
      json[userRemainingLeaveColumnBookedCount],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      userRemainingLeaveColumnId: id,
      userRemainingLeaveColumnEmpId: empId,
      userRemainingLeaveColumnRequestTypeId: requestTypeId,
      userRemainingLeaveColumnBookedCount: bookedCount,
    };
  }
}
