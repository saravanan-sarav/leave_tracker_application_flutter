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
