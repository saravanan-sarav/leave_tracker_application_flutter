import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/localization.dart';

class LocalizationNotifier extends StateNotifier<Localization> {
  LocalizationNotifier(super.state);

  void changeLocale(Localization localization) {
    state = localization;
  }
}

final localizationProvider =
    StateNotifierProvider<LocalizationNotifier, Localization>(
        (ref) => LocalizationNotifier(Localization(1, "en", "english")));
