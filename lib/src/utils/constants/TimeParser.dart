import 'package:flutter/material.dart';

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
