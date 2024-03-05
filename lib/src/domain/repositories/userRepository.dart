import '../models/ReportingToUser.dart';
import '../models/userDetailsModel.dart';

abstract class UserRepository {
  Future<UserData?> authUser(String userEmail, String password);

  Future<ReportingUserDetail> getReportingToUserDetails();
}
