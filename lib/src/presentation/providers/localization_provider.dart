import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/localization_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/localization_repository_impl.dart';

import '../../domain/models/localization.dart';
import '../../domain/repositories/localization_repository.dart';

final localizationDataSourceProvider =
    Provider((ref) => LocalizationDataSource());

final localizationRepositoryProvider = Provider((ref) {
  final localizationDataSource = ref.read(localizationDataSourceProvider);
  return LocalizationRepositoryImpl(localizationDataSource);
});

class LocalizationsNotifier extends StateNotifier<List<Localization>> {
  final LocalizationRepository localizationRepository;

  Future<void> getLocalizationData() async {
    state = await localizationRepository.getAllLocalizationData();
  }

  List<Localization> getLocalizations() {
    return state;
  }

  // List<Localization> getFilteredLocalization(String? value) {
  //   List<Localization> localization = [];
  //   if (value == null) {
  //     return state;
  //   } else {
  //     for (Localization l in state) {
  //       if (l.language.contains(value)) {
  //         localization.add(l);
  //       }
  //     }
  //   }
  //   return localization;
  // }

  LocalizationsNotifier(super.state, this.localizationRepository);
}

final localizationsProvider =
    StateNotifierProvider<LocalizationsNotifier, List<Localization>>((ref) {
  final localizationRepository = ref.read(localizationRepositoryProvider);
  return LocalizationsNotifier([], localizationRepository);
});
