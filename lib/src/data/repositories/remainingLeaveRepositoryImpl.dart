import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasources/local/remainingLeaveDataSource.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/ReqmainingLeaveResponse.dart';
import 'package:leave_tracker_application/src/domain/repositories/remainingLeaveRepository.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';

class RemainingLeaveImpl implements RemainingLeaveRepository {
  final RemainingLeaveDataSource remainingLeaveDataSource;

  RemainingLeaveImpl(this.remainingLeaveDataSource);

  @override
  Future<Either<List<RemainingLeaveResponse>, DataNotFoundException>>
      getAllRemainingLeaves(String empId) async {
    var result = await remainingLeaveDataSource.getAllRemainingLeaveData(empId);
    if (result!.isNotEmpty) {
      return Left(result);
    } else {
      return Right(DataNotFoundException("No Remaining Leave Data"));
    }
  }

  @override
  Future<Either<bool, bool>> updateRemainingLeave(
      String empId, int requestType) async {
    bool? result = await remainingLeaveDataSource
        .updateRemainingLeaveUsingEmpIdAndRequestTypeId(empId, requestType);
    if (result!) {
      return const Left(true);
    } else {
      return const Right(false);
    }
    throw UnimplementedError();
  }
}
