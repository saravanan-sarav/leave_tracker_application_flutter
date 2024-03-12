import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/providers/remainingLeaveProvider.dart';

class RemainingLeavePage extends ConsumerStatefulWidget {
  const RemainingLeavePage({super.key});

  @override
  ConsumerState<RemainingLeavePage> createState() => _RemainingLeavePageState();
}

class _RemainingLeavePageState extends ConsumerState<RemainingLeavePage> {
  @override
  Widget build(BuildContext context) {
    final remainingLeaves =
        ref.read(remainingLeavesProvider.notifier).getLeaveData();

    return Scaffold(
        body: Stack(
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue.shade900,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 20, left: 10),
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
                      "Available Holidays",
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
          margin: EdgeInsets.only(top: 80),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20), topEnd: Radius.circular(20))),
          child: ListView.builder(
              itemCount: remainingLeaves.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.blue.shade900,
                          size: 60,
                        ),
                      ),
                      Expanded(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              remainingLeaves[index].requestType,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Available : ",
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${remainingLeaves[index].allocatedLeave}",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Booked    : ",
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${remainingLeaves[index].bookedCount}",
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                    ]));
              }),
        )
      ],
    ));
  }
}
