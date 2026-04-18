import 'package:dio/dio.dart';

import '../../../domain/models/holiday.dart';

class HolidayListDataSourceApi {
  Future<List<Holiday>> getHolidaysFromApi() async {
    List<Holiday> holidays = [];
    final dio = Dio();
    var response = await dio.get("https://retoolapi.dev/qK0b3f/holidayslist");
    for (var res in response.data) {
      holidays.add(Holiday.fromJson(res));
    }
    return holidays;
  }
}
