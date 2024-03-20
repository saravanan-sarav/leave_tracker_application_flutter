import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/remaining_leave_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/from_time_to_time_state.dart';
import 'package:leave_tracker_application/src/presentation/view/holiday_list_page.dart';
import 'package:leave_tracker_application/src/presentation/view/remaining_leave_page.dart';

import '../../state_management/request_type_state.dart';
import '../../view/create_request_page.dart';

class CreateRequestWidget extends ConsumerWidget {
  const CreateRequestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.37,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create Request",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateRequestPage()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "Leave Of Absence",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(permissionNotifyProvider.notifier).updateState();
                    if (ref
                        .read(permissionNotifyProvider.notifier)
                        .getState()) {
                      ref
                          .read(requestTypeValueProvider.notifier)
                          .changeValue(5);
                      ref.read(requestTypeSelectorProvider.notifier).validate();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateRequestPage()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0, left: 20),
                                child: Text(
                                  "Arrive Late/\nLeave Early",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: InkWell(
                    onTap: () async {
                      await ref
                          .read(remainingLeavesProvider.notifier)
                          .getAllRemainingLeave(ref);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RemainingLeavePage()),
                      );
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 120,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.lock_clock,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "Remaining Leaves",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HolidayListPage()),
                      );
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 120,
                            width: 160,
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.format_list_bulleted_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0, left: 20),
                                child: Text(
                                  "Holiday List",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
          )
        ],
      ),
    );
  }
}
