import 'package:dartz/dartz.dart';
import 'package:leave_tracker_application/src/data/datasource/local/register_employee_data_source.dart';
import 'package:leave_tracker_application/src/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterDataSource registerDataSource;

  RegisterRepositoryImpl(this.registerDataSource);

  Future<bool> checkEmailExists(String email) async {
    bool result = await registerDataSource.checkEmailExists(email);
    return result;
  }
}
