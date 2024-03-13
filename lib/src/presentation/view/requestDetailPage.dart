import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/custom_models/RequestDescriptionDetail.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:leave_tracker_application/src/presentation/providers/notificationProvider.dart';
import 'package:leave_tracker_application/src/presentation/providers/requestProvider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/createdOrSentRequestState.dart';

import '../../utils/constants/TimeParser.dart';
import '../../utils/constants/dateParser.dart';
import '../widgets/SnakeBarWidget.dart';

class RequestDescriptionPage extends ConsumerStatefulWidget {
  const RequestDescriptionPage({super.key});

  @override
  ConsumerState<RequestDescriptionPage> createState() =>
      _RequestDescriptionPageState();
}

class _RequestDescriptionPageState
    extends ConsumerState<RequestDescriptionPage> {
  late RequestDescriptionDetail requestDescriptionDetail;

  void updateRequest(int requestId) async {
    await ref
        .read(requestDescriptionDetailProvider.notifier)
        .getRequestDescriptionByRequestId(requestId);
    await ref
        .read(requestSentToMeProvider.notifier)
        .getSentToMeRequestList(ref);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sentToMe = ref.read(requestSentToMeProvider.notifier);
    requestDescriptionDetail =
        ref.read(requestDescriptionDetailProvider.notifier).getState();
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.blue.shade900,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 20, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Request Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 90),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(10))),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${requestDescriptionDetail.requestType} Requested on ${DateTimeToDateFullView(requestDescriptionDetail.createdAt)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                        color: requestDescriptionDetail.requestStatusId == 1
                            ? Colors.green
                            : requestDescriptionDetail.requestStatusId == 2
                                ? Colors.blue
                                : requestDescriptionDetail.requestStatusId == 3
                                    ? Colors.red
                                    : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Status : ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(requestDescriptionDetail.requestStatus,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          requestDescriptionDetail.requestStatusId == 1
                              ? const Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 15,
                                )
                              : requestDescriptionDetail.requestStatusId == 2
                                  ? const Icon(
                                      Icons.warning_amber,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  : requestDescriptionDetail.requestStatusId ==
                                          3
                                      ? const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : const Icon(Icons.add),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "MAIN INFORMATION",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                                child: Text(
                              "Created By",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${requestDescriptionDetail.empName} (${requestDescriptionDetail.empId})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "@${requestDescriptionDetail.empDesignation} - ${requestDescriptionDetail.empDomain}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                                child: Text(
                              "Request Type",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  requestDescriptionDetail.requestType,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                                child: Text(
                              "From",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatDateAsNumber(
                                      requestDescriptionDetail.fromDate),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  formatDateToDayOfWeek(
                                      requestDescriptionDetail.fromDate),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      requestDescriptionDetail.requestTypeId != 5
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "To",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDateAsNumber(
                                            requestDescriptionDetail.toDate),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        formatDateToDayOfWeek(
                                            requestDescriptionDetail.toDate),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          : const SizedBox(),
                      requestDescriptionDetail.requestTypeId == 5
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "From Time",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatTimeOfDayToIST(
                                            requestDescriptionDetail.fromTime),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          : const SizedBox(),
                      requestDescriptionDetail.requestTypeId == 5
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      child: Text(
                                    "To Time",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatTimeOfDayToIST(
                                            requestDescriptionDetail.toTime),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "OTHER INFORMATION",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Created At",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                                "${formatDateAsNumber(requestDescriptionDetail.createdAt)} (${getTimeFromDate(requestDescriptionDetail.createdAt)}) - ${formatDateToDayOfWeek(requestDescriptionDetail.createdAt)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Request Status Changed At",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            requestDescriptionDetail.approvedAt != null
                                ? Text(
                                    "${formatDateAsNumber(requestDescriptionDetail.approvedAt)} (${getTimeFromDate(requestDescriptionDetail.approvedAt!)}) - ${formatDateToDayOfWeek(requestDescriptionDetail.approvedAt)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.grey))
                                : const Text(
                                    "Not Yet Approved",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Reason",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(requestDescriptionDetail.reason,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey))
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Reporting To",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                foregroundImage: AssetImage(
                                    "assets/images/profile_picture.jpeg"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      requestDescriptionDetail
                                          .reportingToUserName,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${requestDescriptionDetail.reportingToUserDesignation} - ${requestDescriptionDetail.reportingToUserDomain}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: !ref.read(requestCreateOrSentTypeProvider) &&
              requestDescriptionDetail.requestStatusId == 2
          ? BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(right: 40.0, left: 20, top: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await sentToMe.requestStatusChange(
                              requestDescriptionDetail.requestTypeId, 3)) {
                            updateRequest(
                                requestDescriptionDetail.requestTypeId);
                            ref
                                .read(notificationsProvider.notifier)
                                .createNotification(NotificationModel(
                                    1,
                                    requestDescriptionDetail.empId,
                                    requestDescriptionDetail
                                        .reportingToUserName,
                                    requestDescriptionDetail.requestTypeId,
                                    4,
                                    requestDescriptionDetail.reason,
                                    DateTime.now(),
                                    false,
                                    null));
                            var snackbar = customShakingSnackBarWidget(
                              content:
                                  const Text("Status Changed Successfully"),
                              backgroundColor: Colors.blue.shade900,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            var snackbar = customShakingSnackBarWidget(
                              content: const Text("Something Went Wrong"),
                              backgroundColor: Colors.lightBlue.shade900,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade900),
                        child: const Center(
                            child: Text(
                          "Reject",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        )),
                      ),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(right: 40.0, left: 20, top: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await sentToMe.requestStatusChange(
                              requestDescriptionDetail.id, 1)) {
                            updateRequest(requestDescriptionDetail.id);
                            NotificationModel(
                                1,
                                requestDescriptionDetail.empId,
                                requestDescriptionDetail.empName,
                                requestDescriptionDetail.requestTypeId,
                                2,
                                requestDescriptionDetail.reason,
                                DateTime.now(),
                                false,
                                null);
                            ref
                                .read(notificationsProvider.notifier)
                                .createNotification(NotificationModel(
                                    1,
                                    requestDescriptionDetail.empId,
                                    requestDescriptionDetail
                                        .reportingToUserName,
                                    requestDescriptionDetail.requestTypeId,
                                    1,
                                    requestDescriptionDetail.reason,
                                    DateTime.now(),
                                    false,
                                    null));
                            var snackbar = customShakingSnackBarWidget(
                              content:
                                  const Text("Status Changed Successfully"),
                              backgroundColor: Colors.blue.shade900,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            var snackbar = customShakingSnackBarWidget(
                              content: const Text("Something Went Wrong"),
                              backgroundColor: Colors.lightBlue.shade900,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900),
                        child: const Center(
                            child: Text(
                          "Approve",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        )),
                      ),
                    ),
                    label: ""),
              ],
            )
          : !ref.read(requestCreateOrSentTypeProvider) &&
                  requestDescriptionDetail.requestStatusId == 1
              ? BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                              right: 40.0, left: 20, top: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (await sentToMe.requestStatusChange(
                                  requestDescriptionDetail.id, 2)) {
                                updateRequest(requestDescriptionDetail.id);
                                ref
                                    .read(notificationsProvider.notifier)
                                    .createNotification(NotificationModel(
                                        1,
                                        requestDescriptionDetail.empId,
                                        requestDescriptionDetail
                                            .reportingToUserName,
                                        requestDescriptionDetail.requestTypeId,
                                        3,
                                        requestDescriptionDetail.reason,
                                        DateTime.now(),
                                        false,
                                        null));
                                var snackbar = customShakingSnackBarWidget(
                                  content:
                                      const Text("Status Changed Successfully"),
                                  backgroundColor: Colors.blue.shade900,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } else {
                                var snackbar = customShakingSnackBarWidget(
                                  content: const Text("Something Went Wrong"),
                                  backgroundColor: Colors.lightBlue.shade900,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade900),
                            child: const Center(
                                child: Text(
                              "Pending",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            )),
                          ),
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(
                              right: 40.0, left: 20, top: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (await sentToMe.requestStatusChange(
                                  requestDescriptionDetail.id, 3)) {
                                updateRequest(requestDescriptionDetail.id);
                                ref
                                    .read(notificationsProvider.notifier)
                                    .createNotification(NotificationModel(
                                        1,
                                        requestDescriptionDetail.empId,
                                        requestDescriptionDetail
                                            .reportingToUserName,
                                        requestDescriptionDetail.requestTypeId,
                                        4,
                                        requestDescriptionDetail.reason,
                                        DateTime.now(),
                                        false,
                                        null));
                                var snackbar = customShakingSnackBarWidget(
                                  content:
                                      const Text("Status Changed Successfully"),
                                  backgroundColor: Colors.blue.shade900,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } else {
                                var snackbar = customShakingSnackBarWidget(
                                  content: const Text("Something Went Wrong"),
                                  backgroundColor: Colors.lightBlue.shade900,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade900),
                            child: const Center(
                                child: Text(
                              "Reject",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            )),
                          ),
                        ),
                        label: ""),
                  ],
                )
              : !ref.read(requestCreateOrSentTypeProvider) &&
                      requestDescriptionDetail.requestStatusId == 3
                  ? BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.only(
                                  right: 40.0, left: 20, top: 10),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await sentToMe.requestStatusChange(
                                      requestDescriptionDetail.id, 2)) {
                                    updateRequest(requestDescriptionDetail.id);
                                    ref
                                        .read(notificationsProvider.notifier)
                                        .createNotification(NotificationModel(
                                            1,
                                            requestDescriptionDetail.empId,
                                            requestDescriptionDetail
                                                .reportingToUserName,
                                            requestDescriptionDetail
                                                .requestTypeId,
                                            3,
                                            requestDescriptionDetail.reason,
                                            DateTime.now(),
                                            false,
                                            null));
                                    var snackbar = customShakingSnackBarWidget(
                                      content: const Text(
                                          "Status Changed Successfully"),
                                      backgroundColor: Colors.blue.shade900,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  } else {
                                    var snackbar = customShakingSnackBarWidget(
                                      content:
                                          const Text("Something Went Wrong"),
                                      backgroundColor:
                                          Colors.lightBlue.shade900,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow.shade900),
                                child: const Center(
                                    child: Text(
                                  "Pending",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                )),
                              ),
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.only(
                                  right: 40.0, left: 20, top: 10),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await sentToMe.requestStatusChange(
                                      requestDescriptionDetail.id, 1)) {
                                    updateRequest(requestDescriptionDetail.id);
                                    ref
                                        .read(notificationsProvider.notifier)
                                        .createNotification(NotificationModel(
                                            1,
                                            requestDescriptionDetail.empId,
                                            requestDescriptionDetail
                                                .reportingToUserName,
                                            requestDescriptionDetail
                                                .requestTypeId,
                                            2,
                                            requestDescriptionDetail.reason,
                                            DateTime.now(),
                                            false,
                                            null));
                                    var snackbar = customShakingSnackBarWidget(
                                      content: const Text(
                                          "Status Changed Successfully"),
                                      backgroundColor: Colors.blue.shade900,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  } else {
                                    var snackbar = customShakingSnackBarWidget(
                                      content:
                                          const Text("Something Went Wrong"),
                                      backgroundColor:
                                          Colors.lightBlue.shade900,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade900),
                                child: const Center(
                                    child: Text(
                                  "Approve",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                )),
                              ),
                            ),
                            label: ""),
                      ],
                    )
                  : null,
    );
  }
}
