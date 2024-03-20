import 'package:leave_tracker_application/src/domain/models/remaining_leave.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';

import 'reporting_user_detail.dart';

UserData currentLoggedInUser = userDetails[0];

ReportingUserDetailDummy currentUserReportingUserDetail =
    ReportingUserDetailDummy("", "", "", "");

UserRemainingLeaveDataDummy userRemainingLeaveData =
    UserRemainingLeaveDataDummy(0, "", {});

// void setCurrentLoggedInUser(UserData userData) {
//   currentLoggedInUser = userData;
//   currentUserReportingUserDetail =
//       getReportingUserDetailOfCurrentLoggedInUser(currentLoggedInUser.empId);
//   userRemainingLeaveData = getLoggedInUserLeaveData(currentLoggedInUser.empId);
// }

void updateRemainingLeaveData(String empId) {
  userRemainingLeaveData = getLoggedInUserLeaveData(currentLoggedInUser.empId);
}

int? getRemainingLeaveOfCurrentUserByKey(int remainingLeaveType) {
  // If the user is found and the remaining leave type exists, return the remaining leave value
  if (userRemainingLeaveData.remainingLeave.containsKey(remainingLeaveType)) {
    return userRemainingLeaveData.remainingLeave[remainingLeaveType];
  } else {
    return null; // Return null if the user is not found or the remaining leave type does not exist
  }
}
