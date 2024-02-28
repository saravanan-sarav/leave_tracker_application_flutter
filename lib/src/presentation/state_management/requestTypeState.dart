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

  List<RequestType> getState() {
    return state;
  }
}

final requestTypeProvider =
    StateNotifierProvider<RequestTypeNotifier, dynamic>(
  (ref) => RequestTypeNotifier(
    [
      RequestType(1, "Compensatory Off"),
      RequestType(2, "Cyclone Leave"),
      RequestType(3, "Leave Without Pay"),
      RequestType(4, "Leave with Pay"),
      RequestType(5, "Permission"),
      RequestType(6, "Work From Home")
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

  bool getState() {
    return state;
  }
}

final requestTypeSelectorProvider =
    StateNotifierProvider<RequestTypeSelectedNotifier, bool>(
        (ref) => RequestTypeSelectedNotifier(false));

class RequestTypeValueNotifier extends StateNotifier<int> {
  RequestTypeValueNotifier(super.state);

  void changeValue(int value) {
    state = value;
  }

  int getState() {
    return state;
  }
}

final requestTypeValueProvider =
    StateNotifierProvider<RequestTypeValueNotifier, int>(
        (ref) => RequestTypeValueNotifier(0));
