import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasources/local/UserDetailsDataSource.dart';
import 'package:leave_tracker_application/src/data/repositories/UserRepositoryImpl.dart';
import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';
import 'package:leave_tracker_application/src/domain/repositories/userRepository.dart';

final userDetailsDataSourceProvider =
    Provider<UserDetailsDataSource>((ref) => UserDetailsDataSource());

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDetailsDataSource = ref.read(userDetailsDataSourceProvider);
  return UserRepositoryImpl(userDetailsDataSource);
});

final authUserDetailsProvider = StateNotifierProvider((ref) {
  UserRepository userRepository = ref.read(userRepositoryProvider);
  return AuthUserDetailsNotifier(userRepository);
});

class AuthUserDetailsNotifier extends StateNotifier<dynamic> {
  final UserRepository userRepository;

  AuthUserDetailsNotifier(this.userRepository) : super(dynamic);

  Future<void> authUserDetails(String userEmail, String password) async {
    UserData? userData =
        userRepository.authUser(userEmail, password) as UserData?;
    state = userData;
  }
}
