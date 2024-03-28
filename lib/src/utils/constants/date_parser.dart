import 'package:intl/intl.dart';

String dateTimeToDateFullView(DateTime date) {
  final formatter = DateFormat('d MMMM yyyy');
  return formatter.format(date);
}

String formatDateToDayOfWeek(DateTime? date) {
  if (date != null) {
    final formatter = DateFormat('EEEE');
    return formatter.format(date);
  }
  return "";
}

String formatDateAsNumber(DateTime? date) {
  if (date != null) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
  return "";
}

DateTime convertToDate(String input) {
  List<String> parts = input.split('-');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  return DateTime(year, month, day);
}

bool checkDateIsGreater(DateTime dateTime1, DateTime dateTime2) {
  if (dateTime1.year >= dateTime2.year &&
      dateTime1.month >= dateTime2.month &&
      dateTime1.day >= dateTime2.day) {
    return false;
  } else {
    return true;
  }
}

int daysCountBetweenTwoDays(DateTime dateTime1, DateTime dateTime2) {
  return dateTime1.difference(dateTime2).inDays;
}
