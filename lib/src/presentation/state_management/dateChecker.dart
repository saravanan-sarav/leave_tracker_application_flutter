import 'package:flutter_riverpod/flutter_riverpod.dart';

class FromDatePicker extends StateNotifier<DateTime> {
  FromDatePicker(super.state);

  DateTime getState() {
    return state;
  }

  void updateFromDate(DateTime dateTime) {
    state = dateTime;
  }
}

final fromDateProvider = StateNotifierProvider<FromDatePicker, DateTime>(
    (ref) => FromDatePicker(DateTime.now()));


class ToDatePicker extends StateNotifier<DateTime> {
  ToDatePicker(super.state);

  DateTime getState() {
    return state;
  }

  void updateToDate(DateTime dateTime) {
    state = dateTime;
  }
}

final ToDateProvider = StateNotifierProvider<ToDatePicker, DateTime>(
        (ref) => ToDatePicker(DateTime.now()));
