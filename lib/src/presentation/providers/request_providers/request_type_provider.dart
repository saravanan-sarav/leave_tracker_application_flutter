
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_provider.dart';

import '../../../domain/models/request_type.dart';
import '../../../domain/repositories/request_repository.dart';

class RequestTypeNotifier extends StateNotifier<List<RequestType>> {
  final RequestRepository requestRepository;

  RequestTypeNotifier(this.requestRepository) : super([]);

  Future<bool> getRequestType() async {
    final requestTypeOrNotFound = await requestRepository.getRequestTypes();
    requestTypeOrNotFound.fold((l) => state = l, (r) => state = []);
    return true;
  }

  List<RequestType> getRequestTypes() {
    return state;
  }

  String requestTypeName(int id) {
    return state.firstWhere((element) => element.id == id).type;
  }
}

final requestTypesProvider = StateNotifierProvider((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestTypeNotifier(requestRepository);
});