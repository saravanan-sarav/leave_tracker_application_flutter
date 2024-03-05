import 'package:leave_tracker_application/src/data/datasources/local/UserDetailsDataSource.dart';
import 'package:leave_tracker_application/src/domain/models/ReportingToUser.dart';
import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';
import 'package:leave_tracker_application/src/domain/repositories/userRepository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDetailsDataSource userDetailsDataSource;

  UserRepositoryImpl(this.userDetailsDataSource);

  @override
  Future<UserData?> authUser(String userEmail, String password) async {
    UserData? userData =
        await userDetailsDataSource.authUserDetails(userEmail, password);
    if (userData != null) {
      return userData;
    }
    return null;
  }

  @override
  Future<ReportingUserDetail> getReportingToUserDetails() async {
    throw UnimplementedError();
  }
}
