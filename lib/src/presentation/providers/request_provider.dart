import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/data/datasource/local/requests_data_source.dart';
import 'package:leave_tracker_application/src/data/repositories/request_repository_impl.dart';
import 'package:leave_tracker_application/src/domain/models/request.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/request_description_detail.dart';
import 'package:leave_tracker_application/src/domain/models/request_type.dart';
import 'package:leave_tracker_application/src/domain/repositories/request_repository.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';

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
    requestListOrNotFound.fold((l) => state = l, (r) => []);
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

  Future<bool> createRequest(RequestData requestData) async {
    int result = await requestRepository.addRequest(requestData);
    if (result > 0) {
      state.add(requestData);
      getCount();
      return true;
    } else {
      return false;
    }
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

final requestsProvider = StateNotifierProvider((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestsNotifier(requestRepository);
});

class RequestSentToMeNotifier extends StateNotifier<List<RequestData>> {
  final RequestRepository requestRepository;

  RequestSentToMeNotifier(super.state, this.requestRepository);

  Future<bool?> getSentToMeRequestList(WidgetRef ref) async {
    final empId =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().empId;
    final requestDataListOrNotFound =
        await requestRepository.getSentToMeRequestData(empId);
    requestDataListOrNotFound.fold((l) => state = l, (r) => []);
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
}

final requestSentToMeProvider = StateNotifierProvider((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestSentToMeNotifier([], requestRepository);
});

class RequestDescriptionDetailNotifier
    extends StateNotifier<RequestDescriptionDetail> {
  final RequestRepository requestRepository;

  RequestDescriptionDetailNotifier(super.state, this.requestRepository);

  RequestDescriptionDetail getState() {
    return state;
  }

  Future<bool?> getRequestDescriptionByRequestId(int requestId) async {
    RequestDescriptionDetail? result = await requestRepository
        .getRequestDescriptionDetailByRequestId(requestId);
    if (result != null) {
      state = result;
      return true;
    }
    return null;
  }

  updateRequest(int statusId) {
    state.requestStatusId = statusId;
    state.approvedAt = DateTime.now();
  }
}

final requestDescriptionDetailProvider =
    StateNotifierProvider<RequestDescriptionDetailNotifier, dynamic>((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestDescriptionDetailNotifier(
      RequestDescriptionDetail(
          0,
          "",
          "",
          "",
          "",
          0,
          "",
          DateTime.now(),
          DateTime.now(),
          TimeOfDay.now(),
          TimeOfDay.now(),
          DateTime.now(),
          DateTime.now(),
          0,
          "",
          "",
          "",
          "",
          ""),
      requestRepository);
});

class RequestTypeNotifier extends StateNotifier<List<RequestType>> {
  final RequestRepository requestRepository;

  RequestTypeNotifier(this.requestRepository) : super([]);

  Future<bool> getRequestType() async {
    final requestTypeOrNotFound = await requestRepository.getRequestTypes();
    requestTypeOrNotFound.fold((l) => state = l, (r) => []);
    return true;
  }

  String requestTypeName(int id) {
    return state.firstWhere((element) => element.id == id).type;
  }
}

final requestTypesProvider = StateNotifierProvider((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestTypeNotifier(requestRepository);
});
