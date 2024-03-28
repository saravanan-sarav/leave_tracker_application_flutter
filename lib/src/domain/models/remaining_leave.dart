
const String remainingLeaveTableName = "remaining_leave";
const String remainingLeaveColumnId = "id";
const String remainingLeaveColumnAllocatedLeave = "allocated_leave";
const String remainingLeaveColumnRequestTypeId = "request_type_id";

class RemainingLeave {
  final int id;
  final int allocatedLeave;
  final int requestTypeId;

  RemainingLeave(
    this.id,
    this.allocatedLeave,
    this.requestTypeId,
  );

  factory RemainingLeave.fromJson(Map<String, dynamic> json) {
    return RemainingLeave(
      json[remainingLeaveColumnId],
      json[remainingLeaveColumnAllocatedLeave],
      json[remainingLeaveColumnRequestTypeId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      remainingLeaveColumnId: id,
      remainingLeaveColumnAllocatedLeave: allocatedLeave,
      remainingLeaveColumnRequestTypeId: requestTypeId,
    };
  }
}

List<RemainingLeave> remainingLeaves = [
  RemainingLeave(1, 2, 1),
  RemainingLeave(2, 2, 2),
  RemainingLeave(3, 3, 3),
  RemainingLeave(4, 3, 4),
  RemainingLeave(5, 6, 5),
  RemainingLeave(6, 15, 6),
];

class UserRemainingLeaveDataDummy {
  final int id;
  final String empId;
  final Map<int, int> remainingLeave;

  UserRemainingLeaveDataDummy(this.id, this.empId, this.remainingLeave);
}
