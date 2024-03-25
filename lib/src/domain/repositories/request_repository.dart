import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/domain/models/request.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/request_description_detail.dart';
import 'package:leave_tracker_application/src/domain/models/request_type.dart';
import 'package:leave_tracker_application/src/utils/exceptions/data_not_found_exception.dart';

abstract class RequestRepository {
  Future<Either<List<RequestData>, DataNotFoundException>>
      getRequestDetailsUsingEmpId(String empId);

  Future<int> addRequest(RequestData requestData);

  Future<RequestDescriptionDetail?> getRequestDescriptionDetailByRequestId(int requestId);

  Future<Either<List<RequestData>,DataNotFoundException>> getSentToMeRequestData(String empId);

  Future<bool> changeRequestStatus(int requestId, int requestStatusId);
  Future<Either<List<RequestType>, DataNotFoundException>>
  getRequestTypes();
}
