import 'package:leave_tracker_application/src/data/database/db_helper.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDetailsDataSource {
  Future<UserData?> authUserDetails(String userEmail, String password) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          '''select * from $userTableName WHERE $userColumnEmail="$userEmail" AND $userColumnPassword="$password";''');
      if (result.isNotEmpty) {
        return UserData.fromJson(result.first);
      } else {
        return null;
      }
    }
    return null;
  }

  Future<UserData?> getReportingToUserDetails(String empId) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          '''select * from $userTableName WHERE $userColumnEmpId=$empId''');
      if (result.isNotEmpty) {
        return UserData.fromJson(result.first);
      }
    }
    return null;
  }
}
