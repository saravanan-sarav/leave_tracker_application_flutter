import 'package:dartz/dartz.dart';

abstract class RegisterRepository {
  Future<bool> checkEmailExists(String email);
}
