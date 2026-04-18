import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/sent_request_count.dart';

import '../../../domain/models/request.dart';
import '../../../domain/repositories/request_repository.dart';
import '../../state_management/timesheet_tab_state.dart';
import '../user_providers/current_logged_in_provider.dart';

class RequestSentToMeNotifier extends StateNotifier<List<RequestData>> {
  final RequestRepository requestRepository;
  final Ref ref;

  RequestSentToMeNotifier(super.state, this.requestRepository, this.ref);

  Future<bool?> getSentToMeRequestList() async {
    final empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    final requestDataListOrNotFound =
        await requestRepository.getSentToMeRequestData(empId);
    requestDataListOrNotFound.fold((l) => state = l, (r) => state = []);
    ref.read(sentRequestCountProvider.notifier).updateCount();
    return true;
  }

  List<RequestData> getState() {
    if (ref.read(timesheetFilterValueProvider.notifier).state == 0) {
      state.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
      return state;
    } else {
      final filteredData = state
          .where((element) =>
              element.requestStatusId ==
              ref.read(timesheetFilterValueProvider.notifier).state)
          .toList();
      filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
      return filteredData;
    }
  }

  Future<bool> requestStatusChange(int requestId, int statusId) async {
    bool result =
        await requestRepository.changeRequestStatus(requestId, statusId);
    if (result) {
      for (RequestData r in state) {
        if (r.id == requestId) {
          r.requestStatusId = statusId;
          r.approvedAt = DateTime.now();
        }
      }
      return true;
    }
    return false;
  }

  int getCount() {
    final filteredData =
        state.where((element) => element.requestStatusId == 2).toList();
    filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
    return filteredData.length;
  }

  void clearRequestData() {
    state = [];
  }
}

final requestSentToMeProvider =
    StateNotifierProvider<RequestSentToMeNotifier, List<RequestData>>((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestSentToMeNotifier([], requestRepository, ref);
});
