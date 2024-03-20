import 'package:leave_tracker_application/src/domain/models/request_status.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/notification_action.dart';
import '../../domain/models/request.dart';
import '../../domain/models/holiday.dart';
import '../../domain/models/holiday_type.dart';
import '../../domain/models/localization.dart';
import '../../domain/models/notification.dart';
import '../../domain/models/remaining_leave.dart';
import '../../domain/models/request_type.dart';
import '../../domain/models/user_remaining_leave.dart';

class DatabaseHelper {
  static Database? database;

  Future<void> get db async {
    database = await initDatabase();
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, "leave_management.db");
    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    database = db;
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
    await db.execute('''CREATE TABLE $notificationActionTableName (
  $notificationActionColumnId INTEGER PRIMARY KEY,
  $notificationActionColumnActions TEXT)''');
    await db.execute('''
CREATE TABLE $notificationTableName (
  $notificationColumnId INTEGER PRIMARY KEY,
  $notificationColumnEmpId TEXT NOT NULL,
  $notificationColumnName TEXT NOT NULL,
  $notificationColumnRequestTypeId INTEGER NOT NULL,
  $notificationColumnActionId INTEGER,
  $notificationColumnReason TEXT,
  $notificationColumnCreatedAt TEXT,
  $notificationColumnMarkAsRead INTEGER,
  $notificationColumnMarkAsReadAt TEXT,
  FOREIGN KEY ($notificationColumnActionId) REFERENCES $notificationActionTableName($notificationActionColumnId))''');
    await db.execute('''CREATE TABLE $localizationTableName (
  $localizationColumnId INTEGER PRIMARY KEY,
  $localizationColumnLocale TEXT)''');
    await loadUserDetails();
    await loadRequestStatus();
    await loadRequestType();
    await loadHolidayType();
    await loadHolidays();
    await loadRemainingLeave();
    await loadRequestDetails();
    await loadUserRemainingLeave();
    await loadNotificationActions();
    await loadNotification();
    await loadLocalization();
  }
}

Future<void> loadUserDetails() async {
  Database? db = DatabaseHelper.database;
  for (UserData user in userDetails) {
    if (db != null) {
      await db.insert(userTableName, user.toJson());
    } else {}
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

Future<void> loadUserRemainingLeave() async {
  Database? db = DatabaseHelper.database;

  for (UserRemainingLeave request in userRemainingLeaveData) {
    if (db != null) {
      await db.insert(userRemainingLeaveTableName, request.toJson());
    }
  }
}

Future<void> loadNotificationActions() async {
  Database? db = DatabaseHelper.database;

  for (NotificationAction request in notificationActionList) {
    if (db != null) {
      await db.insert(notificationActionTableName, request.toJson());
    }
  }
}

Future<void> loadNotification() async {
  Database? db = DatabaseHelper.database;

  for (NotificationModel request in notificationList) {
    if (db != null) {
      await db.insert(notificationTableName, request.toJson());
    }
  }
}

List<Localization> localizationList = [
  Localization(1, "en"),
  Localization(2, "de")
];

Future<void> loadLocalization() async {
  Database? db = DatabaseHelper.database;
  if (db != null) {
    for (Localization local in localizationList) {
      db.insert(localizationTableName, local.toJson());
    }
  }
}
