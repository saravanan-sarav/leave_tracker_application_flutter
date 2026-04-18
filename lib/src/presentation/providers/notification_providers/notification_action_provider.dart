import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/notification_action.dart';
import '../../../domain/repositories/notification_repository.dart';
import 'notification_provider.dart';

class NotificationActionNotifier
    extends StateNotifier<List<NotificationAction>> {
  final NotificationRepository notificationRepository;

  NotificationActionNotifier(super.state, this.notificationRepository);

  String getNotificationAction(int id) {
    return state.firstWhere((element) => element.id == id).actions;
  }

  Future<void> getNotificationActions() async {
    final notificationActionListOrNotFound =
        await notificationRepository.getAllNotificationAction();
    notificationActionListOrNotFound.fold((l) => state = l, (r) => null);
  }
}

final notificationActionProvider =
    StateNotifierProvider<NotificationActionNotifier, List<NotificationAction>>(
        (ref) {
  final notificationRepository = ref.read(notificationRepositoryProvider);
  return NotificationActionNotifier([], notificationRepository);
});
