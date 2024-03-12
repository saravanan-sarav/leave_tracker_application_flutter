import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/domain/models/remainingLeave.dart';

import '../../utils/exceptions/dataNotFoundException.dart';
import '../models/custom_models/ReqmainingLeaveResponse.dart';

abstract class RemainingLeaveRepository{
  Future<Either<List<RemainingLeaveResponse>,DataNotFoundException>> getAllRemainingLeaves(String empId);

  Future<Either<bool,bool>> updateRemainingLeave(String empId,int requestType);
}