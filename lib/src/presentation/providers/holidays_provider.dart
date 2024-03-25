import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/holidays_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/holiday_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/holiday.dart';

import '../../data/datasource/remote/holiday_list_api.dart';
import '../../domain/models/holiday_type.dart';
import '../../domain/repositories/holiday_repository.dart';

final holidayDataSourceProvider = Provider((ref) => HolidayDataSource());

final holidayDataSourceApiProvider =
    Provider((ref) => HolidayListDataSourceApi());
final holidayRepositoryProvider = Provider((ref) {
  final holidayDataSource = ref.read(holidayDataSourceProvider);
  final holidayApiDataSource = ref.read(holidayDataSourceApiProvider);
  return HolidayRepositoryImpl(holidayDataSource, holidayApiDataSource);
});

final holidaysProvider = StateNotifierProvider((ref) {
  final holidayRepository = ref.read(holidayRepositoryProvider);
  return HolidaysNotifier([], holidayRepository);
});

class HolidaysNotifier extends StateNotifier<List<Holiday>> {
  final HolidayRepository holidayRepository;

  HolidaysNotifier(super.state, this.holidayRepository);

  Future<bool> getAllHolidays() async {
    final holidaysOrNotFound = await holidayRepository.getAllHolidays();
    holidaysOrNotFound.fold((l) => state = l, (r) => []);
    return true;
  }

  Map<int, List<Holiday>> getSortedState() {
    Map<int, List<Holiday>> holidaysByMonth = {};
    state.sort((a, b) => a.date.month.compareTo(b.date.month));
    for (var holiday in state) {
      int month = holiday.date.month;
      if (!holidaysByMonth.containsKey(month)) {
        holidaysByMonth[month] = [];
      }
      holidaysByMonth[month]!.add(holiday);
    }

    return holidaysByMonth;
  }
}

final holidayTypeProvider = StateNotifierProvider((ref) {
  final holidayRepository = ref.read(holidayRepositoryProvider);
  return HolidayTypeNotifier([], holidayRepository);
});

class HolidayTypeNotifier extends StateNotifier<List<HolidayType>> {
  final HolidayRepository holidayRepository;

  HolidayTypeNotifier(super.state, this.holidayRepository);

  Future<bool> getAllHolidayTypes() async {
    final holidaysOrNotFound = await holidayRepository.getHolidayTypes();
    holidaysOrNotFound.fold((l) => state = l, (r) => []);
    return true;
  }

  String getHolidayType(int id) {
    return state.firstWhere((element) => element.id == id).type;
  }
}
