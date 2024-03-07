import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/domain/models/holiday.dart';
import 'package:leave_tracker_application/src/utils/exceptions/dataNotFoundException.dart';

abstract class HolidayRepository {
  Future<Either<List<Holiday>, DataNotFoundException>> getAllHolidays();
}
