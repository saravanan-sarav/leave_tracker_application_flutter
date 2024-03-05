import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? database;

  Future<Database> get db async {
    final path = await getDatabasesPath();
    final databasePath = join(path, "leave_management.db");
    print(databasePath);
    if (database != null) {
      return database!;
    }
    database = await initDatabase();
    return database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, "leave_management.db");

    return await openDatabase(databasePath, version: 1, onCreate: _onCreate);
  }

  Future _onConfigure(Database db) async {
    await db.execute("");
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $userTableName ($userColumnId INTEGER PRIMARY KEY,$userColumnEmpId TEXT,$userColumnName TEXT,$userColumnDomain TEXT,$userColumnDesignation TEXT,$userColumnJoiningDate TEXT,$userColumnEmail TEXT,$userColumnPassword TEXT,$userColumnDateOfBirth TEXT,$userColumnTeamId INTEGER,$userColumnReportingTo TEXT);''');
  }
}
