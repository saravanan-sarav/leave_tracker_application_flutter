import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';

abstract class RequestRepository {
  Future<Either<List<RequestData>, DataNotFoundException>>
      getRequestDetailsUsingEmpId(String empId);

  Future<int> addRequest(RequestData requestData);
}
