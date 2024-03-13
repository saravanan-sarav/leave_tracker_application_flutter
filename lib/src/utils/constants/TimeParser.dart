import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isToTimeIsGreater(TimeOfDay time1, TimeOfDay time2) {
  if (time1.hour > time2.hour) {
    return true;
  } else if (time1.hour < time2.hour) {
    return false;
  } else {
    // Hours are equal, comparing minutes
    if (time1.minute > time2.minute) {
      return true;
    } else {
      return false;
    }
  }
}

String formatTimeOfDayToIST(TimeOfDay? timeOfDay) {
  if (timeOfDay != null) {
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    String formattedTime = '$hour:$minute $period - IST';
    return formattedTime;
  }
  return "";
}

String getTimeFromDate(DateTime dateTime) {
  // Format the DateTime object to get the time
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

TimeOfDay stringToTimeOfDay(String timeString) {
  List<String> parts = timeString.split(':');
  if (parts.length == 2) {
    List<String> hours = parts[0].split("(");
    List<String> minutes = parts[1].split(")");
    int? hour = int.tryParse(hours[1]);
    int? minute = int.tryParse(minutes[0]);
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    }
  }
  return const TimeOfDay(hour: 0, minute: 0);
}

String formatTimeAgo(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} day(s) ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hr(s) ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} min(s) ago';
  } else {
    return 'Just now';
  }
}
