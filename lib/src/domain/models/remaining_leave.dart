
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

List<UserRemainingLeaveDataDummy> userRemainingLeaveDataList = [
  UserRemainingLeaveDataDummy(1, "1001", {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}),
  UserRemainingLeaveDataDummy(2, "101", {1: 0, 2: 0, 3: 1, 4: 2, 5: 0, 6: 0}),
  UserRemainingLeaveDataDummy(2, "1", {1: 0, 2: 0, 3: 1, 4: 2, 5: 0, 6: 0}),
];

UserRemainingLeaveDataDummy getLoggedInUserLeaveData(String empId) {
  return userRemainingLeaveDataList
      .firstWhere((element) => element.empId == empId);
}

// bool updateRemainingLeaveDataByEmpId(String empId, int remainingLeaveType) {
//   final user = userRemainingLeaveDataList.firstWhere(
//     (user) => user.empId == empId,
//   );
//   final updatedRemainingLeave = {...user.remainingLeave};
//   if (updatedRemainingLeave.containsKey(remainingLeaveType)) {
//     print(remainingLeaves[remainingLeaveType].allocatedLeave);
//     print(updatedRemainingLeave[remainingLeaveType]);
//     if (remainingLeaves[remainingLeaveType - 1].allocatedLeave !=
//         updatedRemainingLeave[remainingLeaveType]!) {
//       updatedRemainingLeave[remainingLeaveType] =
//           (updatedRemainingLeave[remainingLeaveType]! + 1);
//       userRemainingLeaveDataList[userRemainingLeaveDataList.indexOf(user)] =
//           UserRemainingLeaveDataDummy(user.id, user.empId, updatedRemainingLeave);
//       updateRemainingLeaveData(empId);
//       return true;
//     } else {
//       return false;
//     }
//   }
//   return false;
// }
//
// class UserRemainingLeave {
//   final int id;
//   final String empId;
//   final int requestTypeId;
//   final int bookedCount;
//
//   UserRemainingLeave(this.id, this.empId, this.requestTypeId, this.bookedCount);
// }
