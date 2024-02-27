import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FromTimePicker extends StateNotifier<TimeOfDay> {
  FromTimePicker(super.state);

  TimeOfDay getState() {
    return state;
  }

  void updateFromTime(TimeOfDay timeOfDay) {
    state = timeOfDay;
  }
}

final fromTimeProvider = StateNotifierProvider<FromTimePicker, TimeOfDay>(
    (ref) => FromTimePicker(TimeOfDay.now()));

class ToTimePicker extends StateNotifier<TimeOfDay> {
  ToTimePicker(super.state);

  TimeOfDay getState() {
    return state;
  }

  void updateToTime(TimeOfDay timeOfDay) {
    state = timeOfDay;
  }
}

final toTimeProvider = StateNotifierProvider<ToTimePicker, TimeOfDay>(
    (ref) => ToTimePicker(TimeOfDay.now()));

class PermissionNotifier extends StateNotifier<bool> {
  PermissionNotifier(super.state);

  void updateState(){
    state = true;
  }

  void setState(){
    state = false;
  }
  bool getState(){
    return state;
  }
}

final permissionNotifyProvider =
    StateNotifierProvider<PermissionNotifier, bool>(
        (ref) => PermissionNotifier(false));
