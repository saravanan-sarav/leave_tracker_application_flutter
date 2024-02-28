class Holiday {
  final DateTime date;
  final String name;
  final HolidayType holidayType;

  Holiday(this.date, this.name, this.holidayType);
}

class HolidayType {
  final int id;
  final String type;

  HolidayType(this.id, this.type);
}

List<HolidayType> holidayTypeList = [
  HolidayType(1, "Holiday"),
  HolidayType(2, "Restricted Holiday")
];

HolidayType findHolidayTypeById(int value) {
  return holidayTypeList.firstWhere((element) => element.id == value);
}

final List<Holiday> holidays = [
  Holiday(DateTime(2024, 1, 1), 'New Year Day', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 1, 26), 'Republic Day', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 1, 15), 'Pongal', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 5, 1), 'May Day', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 7, 15), 'Independence Day', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 10, 2), 'Gandhi Jayanthi', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 10, 11), 'Ayutha Pooja', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 10, 31), 'Diwali', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 12, 25), 'Christmas', findHolidayTypeById(1)),
  Holiday(DateTime(2024, 3, 29), 'Good Friday', findHolidayTypeById(2)),
  Holiday(DateTime(2024, 4, 9), 'Telugu New Year', findHolidayTypeById(2)),
  Holiday(DateTime(2024, 4, 11), 'Ramzan', findHolidayTypeById(2)),
  Holiday(DateTime(2024, 6, 17), 'Bakrid', findHolidayTypeById(2)),
  Holiday(DateTime(2024, 7, 17), 'Muharram', findHolidayTypeById(2)),
  Holiday(DateTime(2024, 8, 26), 'Krishna Jayanthi', findHolidayTypeById(2)),
  Holiday(DateTime(2024, 9, 16), 'Milad-un-Nabi', findHolidayTypeById(2)),
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
