import 'package:leave_tracker_application/src/data/database/dbHelper.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/ReqmainingLeaveResponse.dart';
import 'package:leave_tracker_application/src/domain/models/remainingLeave.dart';
import 'package:leave_tracker_application/src/domain/models/requestType.dart';
import 'package:leave_tracker_application/src/domain/models/userRemainingLeave.dart';
import 'package:sqflite/sqflite.dart';

class RemainingLeaveDataSource {
  Future<List<RemainingLeaveResponse>?> getAllRemainingLeaveData(
      String empId) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<RemainingLeaveResponse> remainingLeaveResponse = [];
      List<Map<String, Object?>> result = await dbClient
          .rawQuery('''SELECT $remainingLeaveTableName.$remainingLeaveColumnId,
          $requestTypeTableName.$requestTypeColumnId AS "request_type_id",
       $requestTypeTableName.$requestTypeColumnType,
       $remainingLeaveTableName.$remainingLeaveColumnAllocatedLeave,
       $userRemainingLeaveTableName.$userRemainingLeaveColumnBookedCount
        FROM $remainingLeaveTableName
        JOIN $requestTypeTableName ON $remainingLeaveTableName.$remainingLeaveColumnRequestTypeId = $requestTypeTableName.$requestTypeColumnId
        JOIN $userRemainingLeaveTableName ON $requestTypeTableName.$requestTypeColumnId=$userRemainingLeaveTableName.$userRemainingLeaveColumnRequestTypeId AND $userRemainingLeaveTableName.$userRemainingLeaveColumnEmpId=$empId
        ORDER BY $requestTypeTableName.$requestTypeColumnId
        ;''');
      for (var res in result) {
        remainingLeaveResponse.add(RemainingLeaveResponse.fromJson(res));
      }
      return remainingLeaveResponse;
    }
    return null;
  }

  Future<bool?> updateRemainingLeaveUsingEmpIdAndRequestTypeId(
      String empId, int requestType) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      var result = await dbClient.rawUpdate(
          '''UPDATE $userRemainingLeaveTableName SET $userRemainingLeaveColumnBookedCount=$userRemainingLeaveColumnBookedCount+1 WHERE $userRemainingLeaveColumnRequestTypeId=$requestType AND $userRemainingLeaveColumnEmpId=$empId;''');
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }


}
