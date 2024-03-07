import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasources/local/requestsDataSource.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
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
}
