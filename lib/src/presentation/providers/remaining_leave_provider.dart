import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/remaining_leave_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/remaining_leave_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/remaining_leave_response.dart';
import 'package:leave_tracker_application/src/domain/repositories/remaining_leave_repository.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';

final remainingLeaveDataSourceProvider =
    Provider((ref) => RemainingLeaveDataSource());

final remainingLeaveRepositoryProvider = Provider((ref) {
  final remainingLeaveDataSource = ref.read(remainingLeaveDataSourceProvider);
  return RemainingLeaveImpl(remainingLeaveDataSource);
});

class RemainingLeaveNotifier
    extends StateNotifier<List<RemainingLeaveResponse>> {
  final RemainingLeaveRepository remainingLeaveRepository;

  RemainingLeaveNotifier(super.state, this.remainingLeaveRepository);

  Future<bool?> getAllRemainingLeave(WidgetRef ref) async {
    final empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    final remainingLeaveOrNotFound =
        await remainingLeaveRepository.getAllRemainingLeaves(empId);
    remainingLeaveOrNotFound.fold((l) => state = l, (r) => []);
    return null;
  }

  Future<bool?> checkSelectedLeaveIsAvailable(
      int remainingLeaveType, WidgetRef ref) async {
    final empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    bool completed = false;
    RemainingLeaveResponse? remainingLeaveResponse = state
        .firstWhere((element) => element.requestTypeId == remainingLeaveType);
    if (remainingLeaveResponse.allocatedLeave >=
        remainingLeaveResponse.bookedCount + 1) {
      final updatedOrFailure = await remainingLeaveRepository
          .updateRemainingLeave(empId, remainingLeaveType);
      updatedOrFailure.fold((l) => completed = true, (r) => completed = false);
      return completed;
    } else {
      return completed;
    }
  }

  List<RemainingLeaveResponse> getLeaveData() {
    return state;
  }
}

final remainingLeavesProvider = StateNotifierProvider((ref) {
  final remainingLeaveRepository = ref.read(remainingLeaveRepositoryProvider);
  return RemainingLeaveNotifier([], remainingLeaveRepository);
});
