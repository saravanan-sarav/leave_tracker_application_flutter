import 'package:intl/intl.dart';

String DateTimeToDateFullView(DateTime date) {
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
