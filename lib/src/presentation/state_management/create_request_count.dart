import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_providers/request_provider.dart';

class CreateRequestCount extends StateNotifier<int> {
  final Ref ref;

  CreateRequestCount(super.state, this.ref);

  void updateCount() {
    state = ref.read(requestsProvider.notifier).getCount();
  }
}

final createRequestCountProvider =
    StateNotifierProvider<CreateRequestCount, int>((ref) => CreateRequestCount(
        ref.read(requestsProvider.notifier).getCount(), ref));
