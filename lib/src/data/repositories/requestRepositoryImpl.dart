import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasources/local/requestsDataSource.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/RequestDescriptionDetail.dart';
import 'package:leave_tracker_application/src/domain/models/requestType.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';

import '../../domain/repositories/requestRepository.dart';

class RequestRepositoryImpl extends RequestRepository {
  final RequestDataSource requestDataSource;

  RequestRepositoryImpl(this.requestDataSource);

  @override
  Future<int> addRequest(RequestData requestData) async {
    int result = await requestDataSource.addRequest(requestData);
    return result;
  }

  @override
  Future<Either<List<RequestData>, DataNotFoundException>>
      getRequestDetailsUsingEmpId(String empId) async {
    List<RequestData>? requestList =
        await requestDataSource.getRequestDetails(empId);
    if (requestList.isNotEmpty) {
      return Left(requestList);
    } else {
      return Right(DataNotFoundException("No Data Found"));
    }
  }

  @override
  Future<RequestDescriptionDetail?> getRequestDescriptionDetailByRequestId(
      int requestId) async {
    return await requestDataSource
        .getRequestDescriptionDetailsByRequestId(requestId);
  }

  @override
  Future<Either<List<RequestData>, DataNotFoundException>>
      getSentToMeRequestData(String empId) async {
    List<RequestData>? result =
        await requestDataSource.getSentToMeRequestDataByEmpId(empId);
    if (result != null) {
      return Left(result);
    } else {
      return Right(DataNotFoundException("No Data Found"));
    }
  }

  @override
  Future<bool> changeRequestStatus(int requestId, int requestStatusId) async {
    bool? result =
        await requestDataSource.updateRequestStatus(requestId, requestStatusId);
    if (result!) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either<List<RequestType>, DataNotFoundException>>
      getRequestTypes() async {
    List<RequestType>? requestList = await requestDataSource.getRequestTypes();
    if (requestList!.isNotEmpty) {
      return Left(requestList);
    } else {
      return Right(DataNotFoundException("No Data Found"));
    }
  }
}
