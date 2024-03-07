import 'package:dartz/dartz.dart';

import '../../utils/exceptions/dataNotFoundException.dart';
import '../models/ReportingUserDetail.dart';
import '../models/user.dart';

abstract class UserRepository {
  Future<Either<UserData, DataNotFoundException>> authUser(
      String userEmail, String password);

  Future<ReportingUserDetail?> getReportingToUserDetails(String empId);
}
