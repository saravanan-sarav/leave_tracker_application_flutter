import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasources/local/requestsDataSource.dart';
import 'package:leave_tracker_application/src/data/repositories/requestRepositoryImpl.dart';
import 'package:leave_tracker_application/src/domain/models/Request.dart';
import 'package:leave_tracker_application/src/domain/repositories/requestRepository.dart';
import 'package:leave_tracker_application/src/presentation/providers/userProvider.dart';

final requestDataSourceProvider = Provider((ref) => RequestDataSource());

final requestRepositoryProvider = Provider((ref) {
  final requestDataSource = ref.read(requestDataSourceProvider);
  return RequestRepositoryImpl(requestDataSource);
});

class RequestsNotifier extends StateNotifier<List<RequestData>> {
  final RequestRepository requestRepository;

  RequestsNotifier(this.requestRepository) : super([]);

  void getUserRequests(WidgetRef ref) async {
    final currentUser = ref.read(currentLoggedInUserDetailsProvider.notifier);
    final requestListOrNotFound = await requestRepository
        .getRequestDetailsUsingEmpId(currentUser.getState().empId);
    requestListOrNotFound.fold((l) => state = l, (r) => []);
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

  Future<bool> createRequest(RequestData requestData) async {
    int result = await requestRepository.addRequest(requestData);
    if (result > 0) {
      state.add(requestData);
      return true;
    } else {
      return false;
    }
  }
}

final requestsProvider = StateNotifierProvider((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestsNotifier(requestRepository);
});
