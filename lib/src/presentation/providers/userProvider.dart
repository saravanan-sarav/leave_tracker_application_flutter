import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasources/local/UserDetailsDataSource.dart';
import 'package:leave_tracker_application/src/data/repositories/UserRepositoryImpl.dart';
import 'package:leave_tracker_application/src/domain/models/ReportingUserDetail.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
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
    final userDataOrNotFound =
        await userRepository.authUser(userEmail, password);
    userDataOrNotFound.fold((l) => state = l, (r) => state = r.message);
  }

  dynamic getAuthUserDetails() {
    return state;
  }

  void clearAuthData() {
    state = null;
  }
}

class CurrentLoggedInUserDetailsNotifier extends StateNotifier<UserData> {
  CurrentLoggedInUserDetailsNotifier(super.state);

  UserData getState() {
    return state;
  }

  void setState(UserData userData) {
    state = userData;
  }
}

final currentLoggedInUserDetailsProvider = StateNotifierProvider((ref) =>
    CurrentLoggedInUserDetailsNotifier(
        ref.read(authUserDetailsProvider.notifier).getAuthUserDetails()));

class ReportingToUserDetailsNotifier
    extends StateNotifier<ReportingUserDetail> {
  final UserRepository userRepository;

  ReportingToUserDetailsNotifier(this.userRepository, super.state);

  Future<void> getReportingToUserDetails(String empId) async {
    ReportingUserDetail? reportingUserDetail =
        await userRepository.getReportingToUserDetails(empId);
    if (reportingUserDetail != null) {
      state = reportingUserDetail;
    }
  }

  ReportingUserDetail getState() {
    return state;
  }
}

final reportingToUserDetailsProvider = StateNotifierProvider((ref) {
  UserRepository userRepository = ref.read(userRepositoryProvider);
  return ReportingToUserDetailsNotifier(
      userRepository, ReportingUserDetail("", "", "", ""));
});
