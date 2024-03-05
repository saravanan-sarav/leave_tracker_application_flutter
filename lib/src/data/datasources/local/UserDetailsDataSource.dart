import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/database/dbHelper.dart';
import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';
import 'package:sqflite/sqflite.dart';

class UserDetailsDataSource{

  Future<UserData?> authUserDetails(String userEmail, String password) async {
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      var result = dbClient.rawQuery(
              "select * from $userTableName WHERE $userColumnEmail=$userEmail AND $userColumnPassword=$password")
          as Map<String, dynamic>;
      return UserData.fromJson(result);
    }
    return null;
  }
}
