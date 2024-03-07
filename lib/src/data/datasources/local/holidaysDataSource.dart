import 'package:leave_tracker_application/src/domain/models/holiday.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/dbHelper.dart';

class HolidayDataSource {
  Future<List<Holiday>?> getAllHolidays() async {
    List<Holiday> holidays = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result =
          await dbClient.rawQuery("select * from $holidayTableName");
      for (var res in result) {
        holidays.add(Holiday.fromJson(res));
      }
      return holidays;
    }
    return null;
  }
}
