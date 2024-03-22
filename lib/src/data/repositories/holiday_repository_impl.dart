import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasource/local/holidays_data_source.dart';
import 'package:leave_tracker_application/src/domain/models/holiday.dart';
import 'package:leave_tracker_application/src/domain/models/holiday_type.dart';
import 'package:leave_tracker_application/src/domain/repositories/holidayRepository.dart';

import '../../utils/exceptions/data_not_found_exception.dart';
import '../datasource/remote/holiday_list_api.dart';

class HolidayRepositoryImpl extends HolidayRepository {
  final HolidayDataSource holidayDataSource;
  final HolidayListDataSourceApi holidayListDataSourceApi;

  HolidayRepositoryImpl(this.holidayDataSource, this.holidayListDataSourceApi);

  @override
  Future<Either<List<Holiday>, DataNotFoundException>> getAllHolidays() async {
    List<Holiday>? holidays =
        await holidayListDataSourceApi.getHolidaysFromApi();
    if (holidays!.isNotEmpty) {
      return Left(holidays);
    } else {
      return Right(DataNotFoundException("No Holidays Found"));
    }
  }

  @override
  Future<Either<List<HolidayType>, DataNotFoundException>>
      getHolidayTypes() async {
    List<HolidayType>? holidays = await holidayDataSource.getHolidayType();
    if (holidays!.isNotEmpty) {
      return Left(holidays);
    } else {
      return Right(DataNotFoundException("No HolidayList Found"));
    }
  }
}
