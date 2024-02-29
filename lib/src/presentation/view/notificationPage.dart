import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/currentLoggedInUser.dart';
import 'package:leave_tracker_application/src/domain/models/notificationModel.dart';
import 'package:leave_tracker_application/src/presentation/state_management/notificationBadgeState.dart';

class NotificationPageWidget extends ConsumerStatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  ConsumerState<NotificationPageWidget> createState() =>
      _NotificationPageWidgetState();
}

class _NotificationPageWidgetState
    extends ConsumerState<NotificationPageWidget> {
  List<NotificationModel>? notificationData =
      getSortedNotifications(currentLoggedInUser.empId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
                  style: TextStyle(
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
                child: ListView.builder(
                  itemCount: notificationData?.length,
                  // The total number of items in the list
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: notificationData![index].markAsRead
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
                                          notificationData![index].name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.0, top: 3),
                                          child: Text(
                                            "created a Request",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      notificationData![index].requestTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      // Limit to 2 lines
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          notificationData![index]
                                              .reasons
                                              .substring(
                                                  0,
                                                  notificationData![index]
                                                              .reasons
                                                              .length >
                                                          30
                                                      ? 30
                                                      : notificationData![index]
                                                          .reasons
                                                          .length),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                        notificationData![index]
                                                    .reasons
                                                    .length >
                                                30
                                            ? Text("...")
                                            : Text("")
                                      ],
                                    ), // Limit to 2 lines),
                                    Text(
                                      formatTimeAgo(
                                          notificationData![index].appliedDate),
                                      style: TextStyle(color: Colors.lightBlue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.mark_email_read_outlined),
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  notificationData![index].markAsRead =
                                      !notificationData![index].markAsRead;
                                  if (notificationData![index].markAsRead) {
                                    ref
                                        .read(
                                            notificationBadgeProvider.notifier)
                                        .decreaseCount();
                                  } else {
                                    ref
                                        .read(
                                            notificationBadgeProvider.notifier)
                                        .increaseCount();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ); // Your custom widget for each item
                  },
                )),
          )
        ],
      ),
    );
  }
}
