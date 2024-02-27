import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leave_tracker_application/src/domain/models/historyTabs.dart';
import 'package:leave_tracker_application/src/domain/models/requestList.dart';
import 'package:leave_tracker_application/src/presentation/state_management/timesheetTabState.dart';

class TimesheetPageWidget extends ConsumerStatefulWidget {
  const TimesheetPageWidget({super.key});

  @override
  ConsumerState<TimesheetPageWidget> createState() =>
      _TimesheetPageWidgetState();
}

class _TimesheetPageWidgetState extends ConsumerState<TimesheetPageWidget> {
  List<RequestData>? applicationDetails = getSortedRequestData(0);
  final DateFormat originalDateFormat =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
  final DateFormat targetDateFormat = DateFormat("dd-MM-yyyy");
  DateFormat formattedDate = DateFormat('dd-MMM');

  void _onStateChange() {
    applicationDetails =
        getSortedRequestData(ref.watch(timesheetFilterValueProvider));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          color: Colors.blue.shade900,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("       "),
              Text(
                "Requests",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.white,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.06, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: historyTabs.length, // Number of tabs
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ref
                              .read(timesheetFilterValueProvider.notifier)
                              .updateValue(index);
                          _onStateChange();
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            historyTabs[index].type,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ref.watch(timesheetFilterValueProvider) ==
                                      index
                                  ? Colors.black
                                  : Colors.grey, // Highlight the selected tab
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: applicationDetails!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            height: MediaQuery.of(context).size.height * 0.15,
                            color:
                                applicationDetails![index].requestStatus?.id ==
                                        1
                                    ? Colors.green.shade50
                                    : applicationDetails![index]
                                                .requestStatus
                                                ?.id ==
                                            2
                                        ? Colors.yellow.shade50
                                        : applicationDetails![index]
                                                    .requestStatus
                                                    ?.id ==
                                                3
                                            ? Colors.red.shade50
                                            : null,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Requested ${applicationDetails![index].requestTitle}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Time : ${targetDateFormat.format(applicationDetails![index].fromDate)}",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Text(
                                                      "Reasons : ${applicationDetails![index].reason.substring(0, applicationDetails![index].reason.length > 20 ? 20 : applicationDetails![index].reason.length)}",
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                applicationDetails![index]
                                                            .reason
                                                            .length >
                                                        20
                                                    ? const Text(
                                                        "...",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    : Text("")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        formattedDate.format(
                                            applicationDetails![index]
                                                .appliedDate),
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Reported To : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                foregroundImage: AssetImage(
                                                    "assets/images/profile_picture.jpeg"),
                                                radius: 15,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "SaravanaKumar",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "PM",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                        );
                      }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
