import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/requests_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/request_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/request_description_detail.dart';
import 'package:leave_tracker_application/src/domain/models/request.dart';
import 'package:leave_tracker_application/src/domain/repositories/request_repository.dart';
import 'package:leave_tracker_application/src/presentation/providers/notification_providers/notification_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/remaining_leave_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/reporting_to_user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/create_request_count.dart';
import 'package:leave_tracker_application/src/presentation/state_management/permission_notifier.dart';

import '../../../domain/models/notification.dart';
import '../../state_management/timesheet_tab_state.dart';
import '../user_providers/current_logged_in_provider.dart';

final requestDataSourceProvider = Provider((ref) => RequestDataSource());

final requestRepositoryProvider = Provider((ref) {
  final requestDataSource = ref.read(requestDataSourceProvider);
  return RequestRepositoryImpl(requestDataSource);
});

class RequestsNotifier extends StateNotifier<List<RequestData>> {
  final RequestRepository requestRepository;
  final StateNotifierProviderRef ref;

  RequestsNotifier(this.requestRepository, this.ref) : super([]);

  Future<bool> getUserRequests() async {
    final currentUser = ref.read(currentLoggedInUserDetailsProvider.notifier);
    final requestListOrNotFound = await requestRepository
        .getRequestDetailsUsingEmpId(currentUser.getState().empId);
    requestListOrNotFound.fold((l) => state = l, (r) => state = []);
    ref.read(createRequestCountProvider.notifier).updateCount();
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

  Future<bool> createRequest(RequestData requestData) async {
    final currentUser =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState();
    final reportingUserId =
        ref.read(reportingToUserDetailsProvider.notifier).getState().empId;
    requestData.reportTo = reportingUserId;
    requestData.empId = currentUser.empId;
    int days = !ref.read(permissionNotifyProvider.notifier).getState()
        ? requestData.toDate!.difference(requestData.fromDate).inDays + 1
        : 1;
    if (await ref
        .read(remainingLeavesProvider.notifier)
        .checkSelectedLeaveIsAvailable(
            requestData.requestTypeId, currentUser.empId, days)) {
      int result = await requestRepository.addRequest(requestData);
      if (result > 0) {
        requestData.id = result;
        await ref.read(notificationsProvider.notifier).createNotification(
            NotificationModel(
                1,
                currentUser.empId,
                currentUser.name,
                requestData.requestTypeId,
                1,
                requestData.reason,
                DateTime.now(),
                false,
                null));
        state.add(requestData);
        ref.read(createRequestCountProvider.notifier).updateCount();
        ref.read(permissionNotifyProvider.notifier).setState();
        return true;
      }
    }
    return false;
  }

  Future<RequestDescriptionDetail?> getRequestDescriptionByRequestId(
      int requestId) async {
    return await requestRepository
        .getRequestDescriptionDetailByRequestId(requestId);
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

final requestsProvider =
    StateNotifierProvider<RequestsNotifier, List<RequestData>>((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestsNotifier(requestRepository, ref);
});
