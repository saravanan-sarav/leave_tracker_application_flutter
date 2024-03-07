const String holidayTableName = "holiday";

const String holidayColumnId = "id";
const String holidayColumnDate = "date";
const String holidayColumnName = "name";
const String holidayColumnTypeId = "holiday_type_id";

class Holiday {
  final int id;
  final DateTime date;
  final String name;
  final int holidayTypeId;

  Holiday(this.id, this.date, this.name, this.holidayTypeId);

  Map<String, dynamic> toJson() {
    return {
      holidayColumnId: id,
      holidayColumnDate: date.toString(),
      holidayColumnName: name,
      holidayColumnTypeId: holidayTypeId,
    };
  }

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      json[holidayColumnId],
      DateTime.parse(json[holidayColumnDate]),
      json[holidayColumnName],
      json[holidayColumnTypeId],
    );
  }
}
