import 'package:leave_tracker_application/src/domain/models/currentLoggedInUser.dart';

class RemainingLeave {
  final int id;
  final String categoryName;
  final int AllotedLeave;

  RemainingLeave(this.id, this.categoryName, this.AllotedLeave);
}

List<RemainingLeave> remainingLeaves = [
  RemainingLeave(1, "Compensatory Leave", 0),
  RemainingLeave(2, "Cyclone Leave", 2),
  RemainingLeave(3, "Leave without Pay", 2),
  RemainingLeave(4, "Leave With Pay", 2),
  RemainingLeave(5, "Permission", 6),
  RemainingLeave(6, "Work From Home", 6),
];

class UserRemainingLeaveData {
  final int id;
  final String empId;
  final Map<int, int> remainingLeave;

  UserRemainingLeaveData(this.id, this.empId, this.remainingLeave);
}

List<UserRemainingLeaveData> userRemainingLeaveDataList = [
  UserRemainingLeaveData(1, "1001", {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0}),
  UserRemainingLeaveData(2, "101", {1: 2, 2: 2, 3: 2, 4: 2, 5: 6, 6: 6}),
];

UserRemainingLeaveData getLoggedInUserLeaveData(String empId) {
  return userRemainingLeaveDataList
      .firstWhere((element) => element.empId == empId);
}

bool updateRemainingLeaveDataByEmpId(String empId, int remainingLeaveType) {
  final user = userRemainingLeaveDataList.firstWhere(
    (user) => user.empId == empId,
  );
  final updatedRemainingLeave = {...user.remainingLeave};
  if (updatedRemainingLeave.containsKey(remainingLeaveType)) {
    print(remainingLeaves[remainingLeaveType].AllotedLeave);
    print(updatedRemainingLeave[remainingLeaveType]);
    if (remainingLeaves[remainingLeaveType - 1].AllotedLeave !=
        updatedRemainingLeave[remainingLeaveType]!) {
      updatedRemainingLeave[remainingLeaveType] =
          (updatedRemainingLeave[remainingLeaveType]! + 1);
      userRemainingLeaveDataList[userRemainingLeaveDataList.indexOf(user)] =
          UserRemainingLeaveData(user.id, user.empId, updatedRemainingLeave);
      updateRemainingLeaveData(empId);
      return true;
    } else {
      return false;
    }
  }
  return false;
}
