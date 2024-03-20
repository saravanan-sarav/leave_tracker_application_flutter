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
      userRemainingLeaveColumnEmpId: empId,
      userRemainingLeaveColumnRequestTypeId: requestTypeId,
      userRemainingLeaveColumnBookedCount: bookedCount,
    };
  }
}

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
];
