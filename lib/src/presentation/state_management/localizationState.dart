import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/localization.dart';



class LocalizationNotifier extends StateNotifier<Localization> {
  LocalizationNotifier(super.state);

  String getLocale() {
    return state.locale;
  }

  void changeLocale(Localization localization) {
    state = localization;
  }
}

final localizationProvider = StateNotifierProvider(
    (ref) => LocalizationNotifier(Localization(1, "en")));
