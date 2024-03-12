import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/RequestDescriptionDetail.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';

abstract class RequestRepository {
  Future<Either<List<RequestData>, DataNotFoundException>>
      getRequestDetailsUsingEmpId(String empId);

  Future<int> addRequest(RequestData requestData);

  Future<RequestDescriptionDetail?> getRequestDescriptionDetailByRequestId(int requestId);

  Future<Either<List<RequestData>,DataNotFoundException>> getSentToMeRequestData(String empId);

  Future<bool> changeRequestStatus(int requestId, int requestStatusId);
}
