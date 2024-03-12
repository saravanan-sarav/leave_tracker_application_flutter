import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasources/local/holidaysDataSource.dart';
import 'package:leave_tracker_application/src/data/repositories/holidayReositoryImpl.dart';
import 'package:leave_tracker_application/src/domain/models/holiday.dart';

import '../../domain/repositories/holidayRepository.dart';

final holidayDataSourceProvider = Provider((ref) => HolidayDataSource());

final holidayRepositoryProvider = Provider((ref) {
  final holidayDataSource = ref.read(holidayDataSourceProvider);
  return HolidayRepositoryImpl(holidayDataSource);
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
