import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasources/local/localizationDataSource.dart';
import 'package:leave_tracker_application/src/data/repositories/localizationRepositoryImpl.dart';

import '../../domain/models/localization.dart';
import '../../domain/repositories/localizationRepository.dart';

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

  Localization getLocalization(int localeId) {
    return state.firstWhere((element) => element.id == localeId);
  }

  List<Localization> getLocalizations() {
    return state;
  }

  LocalizationsNotifier(super.state, this.localizationRepository);
}

final localizationsProvider = StateNotifierProvider((ref) {
  final localizationRepository = ref.read(localizationRepositoryProvider);
  return LocalizationsNotifier([], localizationRepository);
});
