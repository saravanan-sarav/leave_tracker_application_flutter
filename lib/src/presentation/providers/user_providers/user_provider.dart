import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/user_details_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/user_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/domain/repositories/user_repository.dart';
import 'package:leave_tracker_application/src/presentation/providers/remaining_leave_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/reporting_to_user_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_sent_to_me_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_type_provider.dart';

import 'current_logged_in_provider.dart';
import '../holiday_providers/holiday_type_provider.dart';
import '../holiday_providers/holidays_provider.dart';
import '../notification_providers/notification_action_provider.dart';
import '../notification_providers/notification_provider.dart';

final userDetailsDataSourceProvider =
    Provider<UserDetailsDataSource>((ref) => UserDetailsDataSource());

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDetailsDataSource = ref.read(userDetailsDataSourceProvider);
  return UserRepositoryImpl(userDetailsDataSource);
});

final authUserDetailsProvider = StateNotifierProvider<AuthUserDetailsNotifier,dynamic>((ref) {
  UserRepository userRepository = ref.read(userRepositoryProvider);
  return AuthUserDetailsNotifier(userRepository);
});

class AuthUserDetailsNotifier extends StateNotifier<dynamic> {
  final UserRepository userRepository;
  AuthUserDetailsNotifier(this.userRepository) : super(dynamic);

  Future<bool> authUserDetails(
      String userEmail, String password, WidgetRef ref) async {
    final userDataOrNotFound =
        await userRepository.authUser(userEmail, password);
    userDataOrNotFound.fold((l) => state = l, (r) => state = r.message);
    if (state is UserData) {
      final currentLoggedInUserDetails =
          ref.read(currentLoggedInUserDetailsProvider.notifier);
      currentLoggedInUserDetails.setState(getAuthUserDetails());
      ref
          .read(reportingToUserDetailsProvider.notifier)
          .getReportingToUserDetails(
              currentLoggedInUserDetails.getState().reportingTo);
      clearAuthData();
      await ref.read(holidaysProvider.notifier).getAllHolidays();
      await ref.read(holidayTypeProvider.notifier).getAllHolidayTypes();
      await ref.read(requestsProvider.notifier).getUserRequests(ref);
      await ref
          .read(requestSentToMeProvider.notifier)
          .getSentToMeRequestList(ref);
      await ref
          .read(remainingLeavesProvider.notifier)
          .getAllRemainingLeave(ref);
      await ref.read(notificationsProvider.notifier).getAllNotifications(ref);
      await ref
          .read(notificationActionProvider.notifier)
          .getNotificationActions();
      await ref.read(requestTypesProvider.notifier).getRequestType();
      return true;
    }
    return false;
  }

  dynamic getAuthUserDetails() {
    return state;
  }

  void clearAuthData() {
    state = null;
  }
}




