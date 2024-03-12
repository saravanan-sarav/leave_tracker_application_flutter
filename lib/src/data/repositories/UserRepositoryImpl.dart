import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasources/local/UserDetailsDataSource.dart';
import 'package:leave_tracker_application/src/domain/models/ReportingUserDetail.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/domain/repositories/userRepository.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';

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
