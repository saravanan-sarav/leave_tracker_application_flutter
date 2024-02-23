import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestType {
  final int id;
  final String type;

  RequestType(this.id, this.type);
}

class RequestTypeNotifier extends StateNotifier<List<RequestType>> {
  RequestTypeNotifier(super.state);

  void addRequestType(RequestType requestType) {
    state = [...state, requestType];
  }
}

final requestTypeProvider = StateNotifierProvider<RequestTypeNotifier, dynamic>(
  (ref) => RequestTypeNotifier(
    [
      RequestType(1, "Compensatory Off"),
      RequestType(2, "Cyclone Leave"),
      RequestType(3, "Leave Without Pay"),
      RequestType(4, "Leave with Pay"),
      RequestType(5, "Permission")
    ],
  ),
);

class RequestTypeSelectedNotifier extends StateNotifier<bool> {
  RequestTypeSelectedNotifier(super.state);

  void validate() {
    state = true;
  }

  void change() {
    state = false;
  }
}

final requestTypeSelectorProvider =
    StateNotifierProvider<RequestTypeSelectedNotifier, bool>(
        (ref) => RequestTypeSelectedNotifier(false));
