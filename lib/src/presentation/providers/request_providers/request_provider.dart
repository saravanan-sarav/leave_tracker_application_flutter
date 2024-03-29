import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/requests_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/request_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/request_description_detail.dart';
import 'package:leave_tracker_application/src/domain/models/request.dart';
import 'package:leave_tracker_application/src/domain/repositories/request_repository.dart';
import 'package:leave_tracker_application/src/presentation/providers/remaining_leave_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/reporting_to_user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/permission_notifier.dart';

import '../user_providers/current_logged_in_provider.dart';

final requestDataSourceProvider = Provider((ref) => RequestDataSource());

final requestRepositoryProvider = Provider((ref) {
  final requestDataSource = ref.read(requestDataSourceProvider);
  return RequestRepositoryImpl(requestDataSource);
});

class RequestsNotifier extends StateNotifier<List<RequestData>> {
  final RequestRepository requestRepository;

  RequestsNotifier(this.requestRepository) : super([]);

  Future<bool> getUserRequests(WidgetRef ref) async {
    final currentUser = ref.read(currentLoggedInUserDetailsProvider.notifier);
    final requestListOrNotFound = await requestRepository
        .getRequestDetailsUsingEmpId(currentUser.getState().empId);
    requestListOrNotFound.fold((l) => state = l, (r) => state = []);
    getCount();
    return true;
  }

  List<RequestData>? getState(int value) {
    if (value == 0) {
      state.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
      return state;
    }
    if (value > 0) {
      final filteredData =
          state.where((element) => element.requestStatusId == value).toList();
      filteredData.sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
      return filteredData;
    }
    return null;
  }

  Future<bool> createRequest(RequestData requestData, WidgetRef ref) async {
    final empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    final reportingUserId =
        ref.read(reportingToUserDetailsProvider.notifier).getState().empId;
    requestData.reportTo = reportingUserId;
    requestData.empId = empId;
    int days = !ref.read(permissionNotifyProvider.notifier).getState()
        ? requestData.toDate!.difference(requestData.fromDate).inDays + 1
        : 1;
    if (await ref
        .read(remainingLeavesProvider.notifier)
        .checkSelectedLeaveIsAvailable(
            requestData.requestTypeId, empId, days)) {
      int result = await requestRepository.addRequest(requestData);
      if (result > 0) {
        requestData.id = result;
        state.add(requestData);
        getCount();
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
}

final requestsProvider = StateNotifierProvider<RequestsNotifier,List<RequestData>>((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestsNotifier(requestRepository);
});


