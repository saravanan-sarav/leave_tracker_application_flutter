import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasource/local/holidays_data_source.dart';
import 'package:leave_tracker_application/src/domain/models/holiday.dart';
import 'package:leave_tracker_application/src/domain/repositories/holidayRepository.dart';

import '../../utils/exceptions/data_not_found_exception.dart';

class HolidayRepositoryImpl extends HolidayRepository {
  final HolidayDataSource holidayDataSource;

  HolidayRepositoryImpl(this.holidayDataSource);

  @override
  Future<Either<List<Holiday>, DataNotFoundException>> getAllHolidays() async {
    List<Holiday>? holidays = await holidayDataSource.getAllHolidays();
    if (holidays!.isNotEmpty) {
      return Left(holidays);
    } else {
      return Right(DataNotFoundException("No Holidays Found"));
    }
  }
}
