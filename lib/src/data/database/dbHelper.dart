import 'package:leave_tracker_application/src/domain/models/holidayListModelDummy.dart';
import 'package:leave_tracker_application/src/domain/models/requestStatus.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/Request.dart';
import '../../domain/models/holiday.dart';
import '../../domain/models/holidayType.dart';
import '../../domain/models/notification.dart';
import '../../domain/models/remainingLeave.dart';
import '../../domain/models/requestType.dart';
import '../../domain/models/userRemainingLeave.dart';

class DatabaseHelper {
  static Database? database;

  Future<void> get db async {
    // final Directory = await getExternalStorageDirectory();
    // final databasePath = join(Directory!.path, "leave_management.db");
    // await deleteDatabase(databasePath);
    database = await initDatabase();
    // await loadUserDetails();
    // await loadRequestStatus();
    // await loadRequestType();
    // await loadHolidayType();
    // await loadHolidays();
    // await loadRemainingLeave();
    // await loadRequestDetails();
  }

  Future<Database> initDatabase() async {
    final Directory = await getExternalStorageDirectory();
    final databasePath = join(Directory!.path, "leave_management.db");
    return await openDatabase(databasePath, version: 1, onCreate: _onCreate);
  }

  Future _onConfigure(Database db) async {
    await db.execute("");
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $userTableName ($userColumnId INTEGER PRIMARY KEY AUTOINCREMENT,$userColumnEmpId TEXT,$userColumnName TEXT,$userColumnDomain TEXT,$userColumnDesignation TEXT,$userColumnJoiningDate TEXT,$userColumnEmail TEXT,$userColumnPassword TEXT,$userColumnDateOfBirth TEXT,$userColumnTeamId INTEGER,$userColumnReportingTo TEXT);''');
    await db.execute(
        '''CREATE TABLE $requestStatusTableName ($requestStatusColumnId INTEGER PRIMARY KEY AUTOINCREMENT, $requestStatusColumnRequestStatus TEXT)''');
    await db.execute(
        '''CREATE TABLE $requestTypeTableName ($requestTypeColumnId INTEGER PRIMARY KEY AUTOINCREMENT,$requestTypeColumnType TEXT)''');
    await db.execute(
        '''CREATE TABLE $requestDataTableName ($requestDataColumnId INTEGER PRIMARY KEY AUTOINCREMENT,$requestDataColumnEmpId TEXT,$requestDataColumnRequestTitle TEXT,$requestDataColumnRequestTypeId INTEGER,$requestDataColumnProjectName TEXT,$requestDataColumnTeamId TEXT,$requestDataColumnFromDate TEXT,$requestDataColumnToDate TEXT,$requestDataColumnFromTime TEXT,$requestDataColumnToTime TEXT,$requestDataColumnReason TEXT,$requestDataColumnAppliedDate TEXT,$requestDataColumnRequestStatusId INTEGER,$requestDataColumnApprovedAt TEXT,$requestDataColumnReportTo TEXT, FOREIGN KEY ($requestDataColumnRequestStatusId) REFERENCES $requestStatusTableName($requestStatusColumnId),FOREIGN KEY ($requestDataColumnRequestTypeId) REFERENCES $requestTypeTableName($requestTypeColumnId))''');
    await db.execute(
        '''CREATE TABLE $holidayTypeTableName ($holidayTypeColumnId INTEGER PRIMARY KEY,$holidayTypeColumnType TEXT)''');
    await db.execute(
        '''CREATE TABLE $holidayTableName ($holidayColumnId INTEGER PRIMARY KEY,$holidayColumnDate TEXT,$holidayColumnName TEXT,$holidayColumnTypeId INTEGER,FOREIGN KEY ($holidayColumnTypeId) REFERENCES $holidayTypeTableName($holidayTypeColumnId))''');
    await db.execute('''CREATE TABLE $remainingLeaveTableName
         ($remainingLeaveColumnId INTEGER PRIMARY KEY,
         $remainingLeaveColumnAllocatedLeave INTEGER,
         $remainingLeaveColumnRequestTypeId INTEGER,
         FOREIGN KEY ($remainingLeaveColumnRequestTypeId) REFERENCES $requestTypeTableName($requestTypeColumnId))''');

    await db.execute('''CREATE TABLE $userRemainingLeaveTableName (
      $userRemainingLeaveColumnId INTEGER PRIMARY KEY,
      $userRemainingLeaveColumnEmpId TEXT,
      $userRemainingLeaveColumnRequestTypeId INTEGER,
      $userRemainingLeaveColumnBookedCount INTEGER)''');
    await db.execute('''CREATE TABLE $notificationTableName (
      $notificationColumnId INTEGER PRIMARY KEY,
      $notificationColumnEmpId TEXT NOT NULL,
      $notificationColumnRequestTitle TEXT NOT NULL,
      $notificationColumnActions TEXT,
      $notificationColumnCreatedAt TEXT,
      $notificationColumnMarkAsRead INTEGER,
      $notificationColumnMarkAsReadAt TEXT)''');
  }
}

Future<void> loadUserDetails() async {
  Database? db = DatabaseHelper.database;
  for (UserData user in userDetails) {
    if (db != null) {
      await db.insert(userTableName, user.toJson());
    } else {
    }
  }
}

Future<void> loadRequestStatus() async {
  Database? db = DatabaseHelper.database;

  for (RequestStatus request in requestStatusList) {
    if (db != null) {
      await db.insert(requestStatusTableName, request.toJson());
    }
  }
}

Future<void> loadRequestType() async {
  Database? db = DatabaseHelper.database;

  for (RequestType request in requestTypes) {
    if (db != null) {
      await db.insert(requestTypeTableName, request.toJson());
    }
  }
}

Future<void> loadRemainingLeave() async {
  Database? db = DatabaseHelper.database;

  for (RemainingLeave request in remainingLeaves) {
    if (db != null) {
      await db.insert(remainingLeaveTableName, request.toJson());
    }
  }
}

Future<void> loadHolidayType() async {
  Database? db = DatabaseHelper.database;

  for (HolidayType request in holidayTypeList) {
    if (db != null) {
      await db.insert(holidayTypeTableName, request.toJson());
    }
  }
}

Future<void> loadHolidays() async {
  Database? db = DatabaseHelper.database;

  for (Holiday request in holidays) {
    if (db != null) {
      await db.insert(holidayTableName, request.toJson());
    }
  }
}

Future<void> loadRequestDetails() async {
  Database? db = DatabaseHelper.database;

  for (RequestData request in applicationDetails) {
    if (db != null) {
      await db.insert(requestDataTableName, request.toJson());
    }
  }
}