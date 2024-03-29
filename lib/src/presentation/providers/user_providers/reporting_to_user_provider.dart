import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/user_provider.dart';

import '../../../domain/models/reporting_user_detail.dart';
import '../../../domain/repositories/user_repository.dart';

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

final reportingToUserDetailsProvider = StateNotifierProvider<ReportingToUserDetailsNotifier,ReportingUserDetail>((ref) {
  UserRepository userRepository = ref.read(userRepositoryProvider);
  return ReportingToUserDetailsNotifier(
      userRepository, ReportingUserDetail("", "", "", ""));
});