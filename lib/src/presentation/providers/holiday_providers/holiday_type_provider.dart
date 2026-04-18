import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/holiday_type.dart';
import '../../../domain/repositories/holiday_repository.dart';
import 'holidays_provider.dart';

final holidayTypeProvider =
    StateNotifierProvider<HolidayTypeNotifier, List<HolidayType>>((ref) {
  final holidayRepository = ref.read(holidayRepositoryProvider);
  return HolidayTypeNotifier([], holidayRepository);
});

class HolidayTypeNotifier extends StateNotifier<List<HolidayType>> {
  final HolidayRepository holidayRepository;

  HolidayTypeNotifier(super.state, this.holidayRepository);

  Future<bool> getAllHolidayTypes() async {
    final holidaysOrNotFound = await holidayRepository.getHolidayTypes();
    holidaysOrNotFound.fold((l) => state = l, (r) => []);
    return true;
  }

  String getHolidayType(int id) {
    return state.firstWhere((element) => element.id == id).type;
  }
}
