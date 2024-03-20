import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRequestButtonValidationNotifier extends StateNotifier<bool> {
  CreateRequestButtonValidationNotifier(super.state);

  void changeToValid() {
    state = true;
  }

  void changeToInValid() {
    state = false;
  }
}

final createRequestButtonValidationProvider =
    StateNotifierProvider<CreateRequestButtonValidationNotifier, bool>(
        (ref) => CreateRequestButtonValidationNotifier(false));


