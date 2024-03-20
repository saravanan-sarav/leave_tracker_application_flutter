import 'package:leave_tracker_application/src/data/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/models/localization.dart';

class LocalizationDataSource {

  Future<List<Localization>> getAllLocalizationData() async{
    List<Localization> localizationList =[];
    Database? dbClient = DatabaseHelper.database;
    if(dbClient!=null){
      List<Map<String,dynamic>> result =await dbClient.rawQuery("SELECT * FROM $localizationTableName ");
      for(var res in result){
        localizationList.add(Localization.fromJson(res));
      }
    }
    return localizationList;
  }
}
