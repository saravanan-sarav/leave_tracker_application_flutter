import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestCreateOrSentTypeNotifier extends StateNotifier<bool> {
  RequestCreateOrSentTypeNotifier(super.state);

  void validate() {
    state = true;
  }

  void unValidate() {
    state = false;
  }

  bool getState() {
    return state;
  }
}

final requestCreateOrSentTypeProvider =
    StateNotifierProvider<RequestCreateOrSentTypeNotifier, bool>(
        (ref) => RequestCreateOrSentTypeNotifier(true));
