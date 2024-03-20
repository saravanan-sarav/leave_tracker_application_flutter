const String holidayTypeTableName = "holiday_type";
const String holidayTypeColumnId = "id";
const String holidayTypeColumnType = "type";

class HolidayType {
  final int id;
  final String type;

  HolidayType(this.id, this.type);

  Map<String, dynamic> toJson() {
    return {
      holidayTypeColumnId: id,
      holidayTypeColumnType: type,
    };
  }

  factory HolidayType.fromJson(Map<String, dynamic> json) {
    return HolidayType(
      json[holidayTypeColumnId],
      json[holidayTypeColumnType],
    );
  }
}

List<HolidayType> holidayTypeList = [
  HolidayType(1, "Holiday"),
  HolidayType(2, "Restricted Holiday")
];

HolidayType findHolidayTypeById(int value) {
  return holidayTypeList.firstWhere((element) => element.id == value);
}