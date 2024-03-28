import 'package:dartz/dartz.dart';

import '../../utils/exceptions/data_not_found_exception.dart';
import '../models/custom_models/remaining_leave_response.dart';

abstract class RemainingLeaveRepository{
  Future<Either<List<RemainingLeaveResponse>,DataNotFoundException>> getAllRemainingLeaves(String empId);

  Future<Either<bool,bool>> updateRemainingLeave(String empId,int requestType,int days);
}