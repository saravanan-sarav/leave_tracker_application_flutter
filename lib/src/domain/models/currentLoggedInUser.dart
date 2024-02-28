import 'package:leave_tracker_application/src/domain/models/remainingLeaveData.dart';
import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';

UserData currentLoggedInUser = userDetails[0];

ReportingUserDetail currentUserReportingUserDetail =
    ReportingUserDetail("", "", "", "");

UserRemainingLeaveData userRemainingLeaveData =
    UserRemainingLeaveData(0, "", {});

void setCurrentLoggedInUser(UserData userData) {
  currentLoggedInUser = userData;
  currentUserReportingUserDetail =
      getReportingUserDetailOfCurrentLoggedInUser(currentLoggedInUser.empId);
  userRemainingLeaveData = getLoggedInUserLeaveData(currentLoggedInUser.empId);
}

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
