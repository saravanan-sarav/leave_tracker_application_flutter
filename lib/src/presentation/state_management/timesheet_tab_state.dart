import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeSheetValueNotifier extends StateNotifier<int> {
  TimeSheetValueNotifier(super.state);

  updateValue(int value) {
    state = value;
  }

  int getState() {
    return state;
  }
}

final timesheetFilterValueProvider =
    StateNotifierProvider<TimeSheetValueNotifier, int>(
        (ref) => TimeSheetValueNotifier(0));
