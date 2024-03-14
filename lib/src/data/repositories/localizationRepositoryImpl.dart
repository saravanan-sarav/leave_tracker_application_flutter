import 'package:leave_tracker_application/src/data/datasources/local/localizationDataSource.dart';
import 'package:leave_tracker_application/src/domain/repositories/localizationRepository.dart';

import '../../domain/models/localization.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final LocalizationDataSource localizationDataSource;

  LocalizationRepositoryImpl(this.localizationDataSource);

  @override
  Future<List<Localization>> getAllLocalizationData() {
    return localizationDataSource.getAllLocalizationData();
  }
}
