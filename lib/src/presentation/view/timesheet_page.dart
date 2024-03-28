import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leave_tracker_application/src/domain/models/history_tabs.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/created_or_sent_request_state.dart';
import 'package:leave_tracker_application/src/presentation/state_management/timesheet_tab_state.dart';
import 'package:leave_tracker_application/src/presentation/view/request_detail_page.dart';
import 'package:lottie/lottie.dart';

import '../../domain/models/request.dart';

class TimesheetPageWidget extends ConsumerStatefulWidget {
  const TimesheetPageWidget({super.key});

  @override
  ConsumerState<TimesheetPageWidget> createState() =>
      _TimesheetPageWidgetState();
}

class _TimesheetPageWidgetState extends ConsumerState<TimesheetPageWidget> {
  List<RequestData> applicationDetails = [];

  @override
  void initState() {
    applicationDetails = ref.read(requestsProvider.notifier).getState(0)!;
    bool createOrSent = ref.read(requestCreateOrSentTypeProvider);
    if (createOrSent) {
      applicationDetails = ref.read(requestsProvider.notifier).getState(0)!;
    } else {
      applicationDetails =
          ref.read(requestSentToMeProvider.notifier).getState(0)!;
    }
    super.initState();
  }

  final DateFormat originalDateFormat =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
  final DateFormat targetDateFormat = DateFormat("dd-MM-yyyy");
  DateFormat formattedDate = DateFormat('dd-MMM');

  void _onStateChange() {
    if (ref.read(requestCreateOrSentTypeProvider)) {
      applicationDetails = ref
          .read(requestsProvider.notifier)
          .getState(ref.read(timesheetFilterValueProvider))!;
      setState(() {});
    } else {
      applicationDetails = ref
          .read(requestSentToMeProvider.notifier)
          .getState(ref.read(timesheetFilterValueProvider))!;
      setState(() {});
    }
  }

  getRequestDescriptionPageData(int index) async {}

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: Colors.blue.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      ref
                          .read(requestCreateOrSentTypeProvider.notifier)
                          .validate();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                const Text(
                  "Requests",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const Icon(
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
                                color: ref.watch(
                                            timesheetFilterValueProvider) ==
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
                    child: applicationDetails.isEmpty
                        ? Center(
                            child: Lottie.asset(
                              "assets/lotties/no_data_found.json",
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.height * 0.6,
                              repeat: true,
                              reverse: true,
                              animate: true,
                            ),
                          )
                        : RefreshIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                            backgroundColor: Colors.blue,
                            onRefresh: () async {
                              setState(() {});
                              return Future<void>.delayed(
                                  const Duration(seconds: 3));
                            },
                            child: ListView.builder(
                                itemCount: applicationDetails.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      print(applicationDetails[index].id);
                                      await ref
                                          .read(requestDescriptionDetailProvider
                                              .notifier)
                                          .getRequestDescriptionByRequestId(
                                              applicationDetails[index].id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RequestDescriptionPage()),
                                      ).then((value) async {
                                        setState(() {});
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        color: applicationDetails[index]
                                                    .requestStatusId ==
                                                1
                                            ? Colors.green.shade50
                                            : applicationDetails[index]
                                                        .requestStatusId ==
                                                    2
                                                ? Colors.yellow.shade50
                                                : applicationDetails[index]
                                                            .requestStatusId ==
                                                        3
                                                    ? Colors.red.shade50
                                                    : null,
                                        width: double.infinity,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Requested ${applicationDetails[index].requestTitle}",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              "Time : ${targetDateFormat.format(applicationDetails[index].fromDate)}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          20.0),
                                                              child: Text(
                                                                  "Reasons : ${applicationDetails[index].reason.substring(0, applicationDetails[index].reason.length > 15 ? 15 : applicationDetails[index].reason.length)}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                            applicationDetails[
                                                                            index]
                                                                        .reason
                                                                        .length >
                                                                    15
                                                                ? const Text(
                                                                    "...",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  )
                                                                : const Text("")
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    formattedDate.format(
                                                        applicationDetails[
                                                                index]
                                                            .appliedDate),
                                                    style: TextStyle(
                                                        color: Colors.blue[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                               Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 20),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Reported To : ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Row(
                                                        children: [
                                                          const CircleAvatar(
                                                            foregroundImage:
                                                                AssetImage(
                                                                    "assets/images/profile_picture.jpeg"),
                                                            radius: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  ref.read(reportingToUserDetailsProvider.notifier).getState().name,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  ref.read(reportingToUserDetailsProvider.notifier).getState().designation,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
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
                                    ),
                                  );
                                }),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
