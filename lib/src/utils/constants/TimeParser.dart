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
