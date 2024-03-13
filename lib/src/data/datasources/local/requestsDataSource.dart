import 'package:leave_tracker_application/src/data/database/dbHelper.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/RequestDescriptionDetail.dart';
import 'package:leave_tracker_application/src/domain/models/requestStatus.dart';
import 'package:leave_tracker_application/src/domain/models/requestType.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/presentation/state_management/requestTypeState.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';
import 'package:sqflite/sqflite.dart';

class RequestDataSource {
  Future<List<RequestData>> getRequestDetails(String empId) async {
    List<RequestData> requestDataList = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          '''SELECT * FROM $requestDataTableName WHERE $requestDataColumnEmpId="$empId";''');
      for (var res in result) {
        print(res);
        requestDataList.add(RequestData.fromJson(res));
      }
      return requestDataList;
    }
    throw DataNotFoundException("No Data Found in request Data");
  }

  Future<int> addRequest(RequestData requestData) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      int result =
          await dbClient.insert(requestDataTableName, requestData.toJson());
      return result;
    }
    throw DataNotFoundException("No Data Found in request Data");
  }

  Future<RequestDescriptionDetail?> getRequestDescriptionDetailsByRequestId(
      int requestId) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery('''SELECT
          reqData.$requestDataColumnId,
          emp.$userColumnEmpId,
          emp.$userColumnName,
          emp.$userColumnDomain,
          emp.$userColumnDesignation,
          reqData.$requestDataColumnRequestTypeId,
          reqType.$requestTypeColumnType AS request_type,
          reqData.$requestDataColumnFromDate,
          reqData.$requestDataColumnToDate,
          reqData.$requestDataColumnFromTime,
          reqData.$requestDataColumnToTime,
          reqData.$requestDataColumnAppliedDate,
          reqData.$requestDataColumnApprovedAt,
          reqStatus.$requestStatusColumnId AS request_status_id,
          reqStatus.$requestStatusColumnRequestStatus AS request_status,
          reqData.$requestDataColumnReason,
          reportingTo.$userColumnName AS reporting_to_name,
          reportingTo.$userColumnDomain AS reporting_to_domain,
          reportingTo.$userColumnDesignation AS reporting_to_designation
      FROM
      $requestDataTableName AS reqData 
      JOIN
      $requestTypeTableName AS reqType ON reqType.$requestTypeColumnId = reqData.$requestDataColumnRequestTypeId
      JOIN
      $requestStatusTableName AS reqStatus ON reqData.$requestDataColumnRequestStatusId=reqStatus.$requestStatusColumnId
      JOIN
      $userTableName AS emp ON emp.$userColumnEmpId = reqData.$requestDataColumnEmpId
      JOIN
      $userTableName AS reportingTo ON reportingTo.$userColumnEmpId = emp.$userColumnReportingTo
      WHERE reqData.$requestDataColumnId = $requestId;''');
      print(result.first);
      return RequestDescriptionDetail.fromJson(result.first);
    }
    return null;
  }

  Future<List<RequestData>?> getSentToMeRequestDataByEmpId(String empId) async {
    List<RequestData> requestDataList = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          "SELECT * FROM $requestDataTableName WHERE $requestDataColumnReportTo=$empId");
      for (var res in result) {
        print(RequestData.fromJson(res).requestStatusId);
        requestDataList.add(RequestData.fromJson(res));
      }
      return requestDataList;
    }
    return null;
  }

  Future<bool?> updateRequestStatus(int requestId, int requestStatusId) async {
    print("Request ID Came $requestId, Status -> $requestStatusId");
    Database? dbClient = DatabaseHelper.database;
    DateTime dateTime = DateTime.now();
    String date = dateTime.toIso8601String();
    if (dbClient != null) {
      print(
          '''UPDATE $requestDataTableName SET $requestDataColumnRequestStatusId=$requestStatusId, $requestDataColumnApprovedAt="$date" WHERE $requestDataColumnId=$requestId;''');

      var result = await dbClient.rawQuery(
          '''UPDATE $requestDataTableName SET $requestDataColumnRequestStatusId=$requestStatusId, $requestDataColumnApprovedAt="$date" WHERE $requestDataColumnId=$requestId;''');
      print("Data Source $result");
      if (true) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

  Future<List<RequestType>?> getRequestTypes() async {
    List<RequestType> requestTypeList = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          "SELECT * FROM $requestTypeTableName");
      for (var res in result) {
        requestTypeList.add(RequestType.fromJson(res));
      }
      return requestTypeList;
    }
    return null;
  }
}
