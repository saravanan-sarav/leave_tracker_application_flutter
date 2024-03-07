import 'package:leave_tracker_application/src/data/database/dbHelper.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
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
}
