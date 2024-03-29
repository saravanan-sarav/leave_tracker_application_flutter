import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_provider.dart';

import '../../../domain/models/custom_models/request_description_detail.dart';
import '../../../domain/repositories/request_repository.dart';

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
StateNotifierProvider<RequestDescriptionDetailNotifier, RequestDescriptionDetail>((ref) {
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