import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/current_logged_in_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/permission_notifier.dart';

import '../../../domain/models/request_type.dart';
import '../../../domain/repositories/request_repository.dart';

class RequestTypeNotifier extends StateNotifier<List<RequestType>> {
  final RequestRepository requestRepository;
  final StateNotifierProviderRef ref;

  RequestTypeNotifier(this.requestRepository, this.ref) : super([]);

  Future<bool> getRequestType() async {
    final requestTypeOrNotFound = await requestRepository.getRequestTypes();
    requestTypeOrNotFound.fold((l) => state = l, (r) => state = []);
    return true;
  }

  List<RequestType> getRequestTypes() {
    List<RequestType> filtered = [];
    if (!ref.read(permissionNotifyProvider.notifier).getState()) {
      List<RequestType> filtered =
          state.where((r) => r.id != 5 && r.id != 6 && r.id != 7).toList();
      return getFilterByGender(filtered);
    } else {
      for (RequestType r in state) {
        if (r.id == 5) {
          filtered.add(r);
        }
      }
      return getFilterByGender(filtered);
    }
  }

  List<RequestType> getFilterByGender(List<RequestType> filtered) {
    String gender =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState().gender;
    if (gender == "male") {
      filtered.add(state[5]);
    } else {
      filtered.add(state[6]);
    }
    return filtered;
  }

  String requestTypeName(int id) {
    return state.firstWhere((element) => element.id == id).type;
  }
}

final requestTypesProvider =
    StateNotifierProvider<RequestTypeNotifier, List<RequestType>>((ref) {
  final requestRepository = ref.read(requestRepositoryProvider);
  return RequestTypeNotifier(requestRepository, ref);
});
