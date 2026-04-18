import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/user_details_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/user_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/domain/repositories/user_repository.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_type_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/reporting_to_user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/notification_badge_state.dart';
import 'package:leave_tracker_application/src/utils/constants/encryption.dart';

import '../holiday_providers/holiday_type_provider.dart';
import '../holiday_providers/holidays_provider.dart';
import '../notification_providers/notification_action_provider.dart';
import '../notification_providers/notification_provider.dart';
import '../remaining_leave_provider.dart';
import '../request_providers/request_provider.dart';
import '../request_providers/request_sent_to_me_provider.dart';
import 'current_logged_in_provider.dart';

final userDetailsDataSourceProvider =
    Provider<UserDetailsDataSource>((ref) => UserDetailsDataSource());

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userDetailsDataSource = ref.read(userDetailsDataSourceProvider);
  return UserRepositoryImpl(userDetailsDataSource);
});

final authUserDetailsProvider =
    StateNotifierProvider<AuthUserDetailsNotifier, dynamic>((ref) {
  UserRepository userRepository = ref.read(userRepositoryProvider);
  return AuthUserDetailsNotifier(userRepository, ref);
});

class AuthUserDetailsNotifier extends StateNotifier<dynamic> {
  final UserRepository userRepository;
  final Ref ref;

  AuthUserDetailsNotifier(this.userRepository, this.ref) : super(dynamic);

  Future<bool> authUserDetails(String userEmail, String password) async {
    final userDataOrNotFound =
        await userRepository.authUser(userEmail, encryptPassword(password));
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
      await ref.read(requestsProvider.notifier).getUserRequests();
      await ref.read(requestSentToMeProvider.notifier).getSentToMeRequestList();
      await ref.read(remainingLeavesProvider.notifier).getAllRemainingLeave();
      await ref.read(notificationsProvider.notifier).getAllNotifications();
      await ref
          .read(notificationActionProvider.notifier)
          .getNotificationActions();
      await ref.read(requestTypesProvider.notifier).getRequestType();
      return true;
    }
    return false;
  }

  bool logoutUser() {
    ref
        .read(currentLoggedInUserDetailsProvider.notifier)
        .removeLoggedInDetails();
    ref
        .read(reportingToUserDetailsProvider.notifier)
        .removeReportingToUserDetails();
    ref.read(requestsProvider.notifier).clearRequestData();
    ref.read(requestSentToMeProvider.notifier).clearRequestData();
    ref.read(remainingLeavesProvider.notifier).clearLeaveData();
    ref.read(notificationsProvider.notifier).clearNotifications();
    ref.read(notificationBadgeProvider.notifier).updateNotificationCount();
    return true;
  }

  dynamic getAuthUserDetails() {
    return state;
  }

  void clearAuthData() {
    state = null;
  }
}
