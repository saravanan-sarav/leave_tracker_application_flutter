import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/currentLoggedInUser.dart';
import 'package:leave_tracker_application/src/domain/models/requestList.dart';
import 'package:leave_tracker_application/src/presentation/state_management/createdOrSentRequestState.dart';
import 'package:leave_tracker_application/src/presentation/view/timesheetPage.dart';

class ListOfRequestWidget extends ConsumerStatefulWidget {
  const ListOfRequestWidget({super.key});

  @override
  ConsumerState<ListOfRequestWidget> createState() =>
      _ListOfRequestWidgetState();
}

class _ListOfRequestWidgetState extends ConsumerState<ListOfRequestWidget> {
  @override
  Widget build(BuildContext context) {
    Color containerColor = Colors.white;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "List Of Requests",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              ref.read(requestCreateOrSentTypeProvider.notifier).validate();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TimesheetPageWidget()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: containerColor,
                  // Container background color
                  borderRadius: BorderRadius.circular(15),
                  // Adjust border radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200, // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 5, // Blur radius
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Created By Me...",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          countApplicationsByEmpId(currentLoggedInUser.empId) !=
                                  0
                              ? Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 25,
                                  width: 30,
                                  child: Center(
                                      child: Text(
                                    "${countApplicationsByEmpId(currentLoggedInUser.empId)}",
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(requestCreateOrSentTypeProvider.notifier).unValidate();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TimesheetPageWidget()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: containerColor,
                  // Container background color
                  borderRadius: BorderRadius.circular(15),
                  // Adjust border radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200, // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 5, // Blur radius
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Sent To Me..",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          countApplicationsSentToMeByEmpId(
                                      currentLoggedInUser.empId) !=
                                  0
                              ? Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 25,
                                  width: 30,
                                  child: Center(
                                      child: Text(
                                    "${countApplicationsSentToMeByEmpId(currentLoggedInUser.empId)}",
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
