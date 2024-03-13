import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:leave_tracker_application/src/presentation/providers/notificationProvider.dart';
import 'package:leave_tracker_application/src/presentation/providers/requestProvider.dart';
import 'package:leave_tracker_application/src/utils/constants/dateParser.dart';

import '../../utils/constants/TimeParser.dart';
import '../state_management/notificationBadgeState.dart';

class NotificationPageWidget extends ConsumerStatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  ConsumerState<NotificationPageWidget> createState() =>
      _NotificationPageWidgetState();
}

class _NotificationPageWidgetState
    extends ConsumerState<NotificationPageWidget> {
  List<NotificationModel> notificationData = [];

  @override
  void initState() {
    notificationData =
        ref.read(notificationsProvider.notifier).getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationAction = ref.read(notificationActionProvider.notifier);
    final requestType = ref.read(requestTypesProvider.notifier);

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue.shade900,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                AppLocalizations.of(context)!.notifications,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade100,
              child: RefreshIndicator(
                backgroundColor: Colors.blue,
                color: Colors.white,
                onRefresh: () async {
                  await ref
                      .read(notificationsProvider.notifier)
                      .getAllNotifications(ref);
                  notificationData = await ref
                      .read(notificationsProvider.notifier)
                      .getNotifications();
                  setState(() {});
                },
                child: ListView.builder(
                  itemCount: notificationData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: notificationData[index].markAsRead
                              ? Colors.white
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 10),
                              child: CircleAvatar(
                                radius: 27,
                                foregroundImage: AssetImage(
                                    "assets/images/profile_picture.jpeg"),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${notificationAction.getNotificationAction(notificationData[index].actionId)}",
                                          style: TextStyle(
                                              color: notificationData[index]
                                                          .actionId ==
                                                      1
                                                  ? Colors.blue
                                                  : notificationData[index]
                                                              .actionId ==
                                                          2
                                                      ? Colors.green
                                                      : notificationData[index]
                                                                  .actionId ==
                                                              3
                                                          ? Colors.yellow
                                                          : notificationData[
                                                                          index]
                                                                      .actionId ==
                                                                  4
                                                              ? Colors.red
                                                              : null,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6.0, top: 3),
                                          child: Text(
                                            "by - ${notificationData[index].name}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      requestType.requestTypeName(
                                          notificationData[index]
                                              .requestTypeId),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      // Limit to 2 lines
                                    ),
                                    Row(
                                      children: [
                                        const Text("Reason : "),
                                        Text(
                                          notificationData[index]
                                              .reason
                                              .substring(
                                                  0,
                                                  notificationData[index]
                                                              .reason
                                                              .length >
                                                          30
                                                      ? 30
                                                      : notificationData[index]
                                                          .reason
                                                          .length),
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        notificationData[index].reason.length >
                                                30
                                            ? const Text("...")
                                            : const Text("")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${formatDateAsNumber(notificationData[index].createdAt)} - ",
                                          style: const TextStyle(
                                              color: Colors.lightBlue),
                                        ),
                                        Text(
                                          formatTimeAgo(notificationData[index]
                                              .createdAt),
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.mark_email_read_outlined),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      if (notificationData[index].markAsRead) {
                                        ref
                                            .read(notificationBadgeProvider
                                                .notifier)
                                            .increaseCount();
                                      } else {
                                        ref
                                            .read(notificationBadgeProvider
                                                .notifier)
                                            .decreaseCount();
                                      }
                                      await ref
                                          .read(notificationsProvider.notifier)
                                          .markAsReadNotification(
                                              notificationData[index].id,
                                              notificationData[index].markAsRead);
                                      setState(() {});
                                    },
                                  ),
                                  notificationData[index].markAsRead == true
                                      ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Read By",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11)),
                                          Text(
                                              "${formatTimeAgo(notificationData[index].markAsReadAt!)}",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11)),
                                        ],
                                      )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ); // Your custom widget for each item
                  },
                ),
              )),
        )
      ],
    );
  }
}
