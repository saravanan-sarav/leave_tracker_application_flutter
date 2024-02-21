import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class Localization {
  final String locale;

  const Localization(this.locale);
}

class LocalizationNotifier extends StateNotifier<Localization> {
  LocalizationNotifier(super.state);

  String getLocale(){
    return state.locale;
  }
  void changeLocale(String locale) {
    state = Localization(locale);
  }
}

final LocalizationProvider = StateNotifierProvider((ref) => LocalizationNotifier(const Localization("en")));