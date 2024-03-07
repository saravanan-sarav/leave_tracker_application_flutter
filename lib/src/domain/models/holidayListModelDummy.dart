import 'holiday.dart';
import 'holidayType.dart';


HolidayType findHolidayTypeById(int value) {
  return holidayTypeList.firstWhere((element) => element.id == value);
}

final List<Holiday> holidays = [
  Holiday(1, DateTime(2024, 1, 1), 'New Year Day', 1),
  Holiday(2, DateTime(2024, 1, 26), 'Republic Day', 1),
  Holiday(3, DateTime(2024, 1, 15), 'Pongal', 1),
  Holiday(4, DateTime(2024, 5, 1), 'May Day', 1),
  Holiday(5, DateTime(2024, 7, 15), 'Independence Day', 1),
  Holiday(6, DateTime(2024, 10, 2), 'Gandhi Jayanthi', 1),
  Holiday(7, DateTime(2024, 10, 11), 'Ayutha Pooja', 1),
  Holiday(8, DateTime(2024, 10, 31), 'Diwali', 1),
  Holiday(9, DateTime(2024, 12, 25), 'Christmas', 1),
  Holiday(10, DateTime(2024, 3, 29), 'Good Friday', 2),
  Holiday(11, DateTime(2024, 4, 9), 'Telugu New Year', 2),
  Holiday(12, DateTime(2024, 4, 11), 'Ramzan', 2),
  Holiday(13, DateTime(2024, 6, 17), 'Bakrid', 2),
  Holiday(14, DateTime(2024, 7, 17), 'Muharram', 2),
  Holiday(15, DateTime(2024, 8, 26), 'Krishna Jayanthi', 2),
  Holiday(16, DateTime(2024, 9, 16), 'Milad-un-Nabi', 2),
  // Add more holidays...
];

Map<int, List<Holiday>> parseHolidaysByMonth() {
  Map<int, List<Holiday>> holidaysByMonth = {};
  holidays.sort((a, b) => a.date.month.compareTo(b.date.month));
  for (var holiday in holidays) {
    int month = holiday.date.month;
    if (!holidaysByMonth.containsKey(month)) {
      holidaysByMonth[month] = [];
    }
    holidaysByMonth[month]!.add(holiday);
  }

  return holidaysByMonth;
}
