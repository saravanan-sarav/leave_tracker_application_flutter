import 'package:leave_tracker_application/src/domain/models/holiday.dart';
import 'package:leave_tracker_application/src/domain/models/holiday_type.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/db_helper.dart';

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

  Future<List<HolidayType>?> getHolidayType() async {
    List<HolidayType> holidayTypeList = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result =
      await dbClient.rawQuery("select * from $holidayTypeTableName");
      for (var res in result) {
        holidayTypeList.add(HolidayType.fromJson(res));
      }
      return holidayTypeList;
    }
    return null;
  }
}
