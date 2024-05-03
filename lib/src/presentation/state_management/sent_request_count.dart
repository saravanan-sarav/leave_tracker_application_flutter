import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/request_providers/request_sent_to_me_provider.dart';

class SentRequestCount extends StateNotifier<int> {
  SentRequestCount(super.state, this.ref);

  final StateNotifierProviderRef ref;

  void updateCount() {
    state = ref.read(requestSentToMeProvider.notifier).getCount();
  }
}

final sentRequestCountProvider = StateNotifierProvider<SentRequestCount, int>(
    (ref) => SentRequestCount(0, ref));
