import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/localization.dart';

class LocalizationNotifier extends ChangeNotifier {
  Localization _state;

  LocalizationNotifier(this._state);

  String getLocale() {
    return _state.locale;
  }

  void changeLocale(Localization localization) {
    _state = localization;
    notifyListeners();
  }
}

final localizationProvider = ChangeNotifierProvider(
    (ref) => LocalizationNotifier(Localization(1, "en")));
