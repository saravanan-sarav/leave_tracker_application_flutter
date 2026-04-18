import 'package:leave_tracker_application/src/data/database/db_helper.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:sqflite/sqflite.dart';

class RegisterDataSource {
  Future<bool> checkEmailExists(String email) async {
    print("Register DS Came");
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          '''SELECT COUNT($userColumnEmail) FROM $userTableName WHERE $userColumnEmail="$email"''');
      if (result.isNotEmpty && result.first['COUNT(email)'] > 0) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
}
