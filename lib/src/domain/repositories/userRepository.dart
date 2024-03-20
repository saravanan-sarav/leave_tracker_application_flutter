import 'package:dartz/dartz.dart';

import '../../utils/exceptions/data_not_found_exception.dart';
import '../models/reporting_user_detail.dart';
import '../models/user.dart';

abstract class UserRepository {
  Future<Either<UserData, DataNotFoundException>> authUser(
      String userEmail, String password);

  Future<ReportingUserDetailDummy?> getReportingToUserDetails(String empId);
}
