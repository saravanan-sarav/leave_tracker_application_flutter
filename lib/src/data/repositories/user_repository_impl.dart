import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasource/local/user_details_data_source.dart';
import 'package:leave_tracker_application/src/domain/models/reporting_user_detail.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/domain/repositories/userRepository.dart';
import 'package:leave_tracker_application/src/utils/exceptions/data_not_found_exception.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDetailsDataSource userDetailsDataSource;

  UserRepositoryImpl(this.userDetailsDataSource);

  @override
  Future<Either<UserData, DataNotFoundException>> authUser(
      String userEmail, String password) async {
    UserData? userData =
        await userDetailsDataSource.authUserDetails(userEmail, password);
    if (userData != null) {
      return Left(userData);
    } else {
      return Right(DataNotFoundException("InValid Credentials"));
    }
  }

  @override
  Future<ReportingUserDetailDummy?> getReportingToUserDetails(String empId) async {
    UserData? userData =
        await userDetailsDataSource.getReportingToUserDetails(empId);
    if (userData != null) {
      return ReportingUserDetailDummy(userData.empId, userData.name,
          userData.designation, userData.designation);
    }
    return null;
  }
}
