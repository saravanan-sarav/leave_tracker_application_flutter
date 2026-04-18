import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/register_employee_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/register_repository_impl.dart';

import '../../../domain/repositories/register_repository.dart';

final registerDataSourceProvider = Provider((ref) => RegisterDataSource());

final registerRepositoryProvider = Provider((ref) {
  final registerDataSource = ref.read(registerDataSourceProvider);
  return RegisterRepositoryImpl(registerDataSource);
});

class CheckEmailExistsNotifier extends StateNotifier<bool> {
  final RegisterRepository registerRepository;

  CheckEmailExistsNotifier(super.state, this.registerRepository);

  Future<bool> checkEmail(String value) async {
    print("SM came");
    state = await registerRepository.checkEmailExists(value);
    return state;
  }
}

final checkEmailExistsProvider =
    StateNotifierProvider<CheckEmailExistsNotifier, bool>((ref) {
  final registerRepository = ref.read(registerRepositoryProvider);
  return CheckEmailExistsNotifier(false, registerRepository);
});
