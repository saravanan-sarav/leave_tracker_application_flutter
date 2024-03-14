
import '../models/localization.dart';

abstract class LocalizationRepository {
  Future<List<Localization>> getAllLocalizationData();
}
