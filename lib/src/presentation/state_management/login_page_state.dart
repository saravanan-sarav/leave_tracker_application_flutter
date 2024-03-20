import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageEmailNotifier extends StateNotifier<String> {
  LoginPageEmailNotifier(super.state);

  setState(String value) {
    state = value;
  }

  String getState() {
    return state;
  }
}

final loginPageEmailProvider =
    StateNotifierProvider<LoginPageEmailNotifier, String>(
        (ref) => LoginPageEmailNotifier(""));

class LoginPagePasswordNotifier extends StateNotifier<String> {
  LoginPagePasswordNotifier(super.state);

  setState(String value) {
    state = value;
  }

  String getState() {
    return state;
  }
}

final loginPagePasswordProvider =
    StateNotifierProvider<LoginPagePasswordNotifier, String>(
        (ref) => LoginPagePasswordNotifier(""));
