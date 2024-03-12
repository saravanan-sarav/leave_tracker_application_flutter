import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';

class CreatedByMeIndicatorNotifier extends StateNotifier {
  CreatedByMeIndicatorNotifier(super.state);

  void updateCount(List<RequestData> list) {
    state = list.length;
  }

  int getCount() {
    return state;
  }
}

final createdByMeIndicatorProvider =
    StateNotifierProvider((ref) => CreatedByMeIndicatorNotifier(0));

class SentToMeIndicatorNotifier extends StateNotifier {
  SentToMeIndicatorNotifier(super.state);

  void updateCount(List<RequestData> list) {
    state = list.length;
  }

  int getCount() {
    return state;
  }
}

final sentToMeIndicatorProvider =
StateNotifierProvider((ref) => SentToMeIndicatorNotifier(0));