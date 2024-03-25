import 'package:leave_tracker_application/src/data/datasource/local/localization_data_source.dart';
import 'package:leave_tracker_application/src/domain/repositories/localization_repository.dart';

import '../../domain/models/localization.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final LocalizationDataSource localizationDataSource;

  LocalizationRepositoryImpl(this.localizationDataSource);

  @override
  Future<List<Localization>> getAllLocalizationData() {
    return localizationDataSource.getAllLocalizationData();
  }
}
