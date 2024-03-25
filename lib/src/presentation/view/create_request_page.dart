import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leave_tracker_application/src/domain/models/current_logged_in_user.dart';
import 'package:leave_tracker_application/src/domain/models/request_status.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/presentation/providers/notification_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/remaining_leave_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/date_checker.dart';
import 'package:leave_tracker_application/src/presentation/state_management/from_time_to_time_state.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/appbar_widget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/date_time_picker_widget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/drop_down_widget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/text_field_widget.dart';

import '../../domain/models/notification.dart';
import '../../domain/models/request.dart';
import '../../utils/constants/time_parser.dart';
import '../state_management/request_type_state.dart';
import '../widgets/snack_bar_widget.dart';

class CreateRequestPage extends ConsumerStatefulWidget {
  const CreateRequestPage({super.key});

  @override
  ConsumerState<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends ConsumerState<CreateRequestPage> {
  bool fromDateChanged = false;
  bool toDateChanged = false;
  bool fromTimeChanged = false;
  bool toTimeChanged = false;

  final TextEditingController _requestTextController = TextEditingController();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _teamIdController = TextEditingController();
  final TextEditingController _reasonTextController = TextEditingController();

  final DateFormat originalDateFormat =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
  final DateFormat targetDateFormat = DateFormat("dd-MM-yyyy");

  void openFromDatePicker() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const SizedBox(height: 320, child: DatePickerWidget());
        });
    fromDateChanged == false ? fromDateChanged = true : null;
  }

  void openToDatePicker() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const SizedBox(height: 320, child: ToDatePickerWidget());
        });
    toDateChanged == false ? toDateChanged = true : null;
  }

  void openFromTimePicker(BuildContext context) async {
    TimeOfDay selectedFromTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedFromTime,
        barrierLabel: "Select From Time");
    if (picked != null && picked != selectedFromTime) {
      selectedFromTime = picked;
    }
    ref.read(fromTimeProvider.notifier).updateFromTime(selectedFromTime);
    fromTimeChanged == false ? fromTimeChanged = true : null;
  }

  void openToTimePicker(BuildContext context) async {
    TimeOfDay selectedToTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedToTime,
        barrierLabel: "Select From Time");
    if (picked != null && picked != selectedToTime) {
      selectedToTime = picked;
    }
    ref.read(toTimeProvider.notifier).updateToTime(selectedToTime);
    toTimeChanged == false ? toTimeChanged = true : null;
  }

  String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  // bool _requestTittleFilled = false;
  // bool _requestTypeFilled = false;
  // bool _projectNameFilled = false;
  // bool _teamIdFilled = false;
  // bool _fromDateFilled = false;
  // bool _toDateFilled = false;
  // bool _reasonFilled = false;
  // bool _fromTimeFilled = false;
  // bool _toTimeFilled = false;

  @override
  void initState() {
    super.initState();
  }

  submitRequestData() async {
    bool validationSuccessful = false;
    RequestData requestData = RequestData(
        applicationDetails.length + 1,
        currentLoggedInUser.empId,
        "",
        0,
        "",
        "",
        DateTime.now(),
        null,
        null,
        null,
        "",
        DateTime.now(),
        2,
        null,
        currentUserReportingUserDetail.empId);
    if (_requestTextController.text.isNotEmpty) {
      requestData.requestTitle = _requestTextController.text;
      if (ref.read(requestTypeSelectorProvider.notifier).getState()) {
        requestData.requestTypeId =
            ref.read(requestTypeValueProvider.notifier).getState();
        if (_projectNameController.text.isNotEmpty) {
          requestData.projectName = _projectNameController.text;
          if (_teamIdController.text.isNotEmpty) {
            requestData.teamId = _teamIdController.text;
            if (fromDateChanged) {
              requestData.fromDate =
                  ref.read(fromDateProvider.notifier).getState();
              if (_reasonTextController.text.isNotEmpty) {
                requestData.reason = _reasonTextController.text;
                if (ref.read(permissionNotifyProvider.notifier).getState()) {
                  if (fromTimeChanged) {
                    requestData.fromTime =
                        ref.read(fromTimeProvider.notifier).getState();
                    if (toTimeChanged) {
                      if (!isToTimeIsGreater(
                          ref.read(fromTimeProvider.notifier).getState(),
                          ref.read(toTimeProvider.notifier).getState())) {
                        requestData.toTime =
                            ref.read(toTimeProvider.notifier).getState();
                        validationSuccessful = true;
                      } else {
                        var snackBar = customShakingSnackBarWidget(
                          content: const Text("Enter Correct To Time..."),
                          backgroundColor:
                              Colors.red, // Background color of the snackBar
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      var snackBar = customShakingSnackBarWidget(
                        content: const Text("Please Enter To Time...!!!"),
                        backgroundColor:
                            Colors.red, // Background color of the snackBar
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    var snackBar = customShakingSnackBarWidget(
                      content: const Text("Please Enter From Time...!!!"),
                      backgroundColor:
                          Colors.red, // Background color of the snackBar
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  if (toDateChanged) {
                    if (ref
                            .read(fromDateProvider.notifier)
                            .getState()
                            .compareTo(
                                ref.read(toDateProvider.notifier).getState()) <
                        0) {
                      ref.read(permissionNotifyProvider.notifier).setState();
                      requestData.toDate =
                          ref.read(toDateProvider.notifier).getState();
                      validationSuccessful = true;
                    } else {
                      var snackBar = customShakingSnackBarWidget(
                        content: const Text("Enter Correct To Date..."),
                        backgroundColor:
                            Colors.red, // Background color of the snackBar
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    var snackBar = customShakingSnackBarWidget(
                      content: const Text("Please Enter To Date...!!!"),
                      backgroundColor:
                          Colors.red, // Background color of the snackBar
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              } else {
                var snackBar = customShakingSnackBarWidget(
                  content: const Text("Please Enter reason...!!!"),
                  backgroundColor:
                      Colors.red, // Background color of the snackBar
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              var snackBar = customShakingSnackBarWidget(
                content: const Text("Please Select From Date...!!!"),
                backgroundColor: Colors.red, // Background color of the snackBar
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            var snackBar = customShakingSnackBarWidget(
              content: const Text("Please Enter Team Id...!!!"),
              backgroundColor: Colors.red, // Background color of the snackBar
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          var snackBar = customShakingSnackBarWidget(
            content: const Text("Please Enter Project Name...!!!"),
            backgroundColor: Colors.red, // Background color of the snackBar
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        var snackBar = customShakingSnackBarWidget(
          content: const Text("Please Select RequestType...!!!"),
          backgroundColor: Colors.red, // Background color of the snackBar
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      var snackBar = customShakingSnackBarWidget(
        content: const Text("Please enter Request Title..!!!"),
        backgroundColor: Colors.red, // Background color of the snackBar
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (validationSuccessful) {
      bool? leaveAvailable = await ref
          .read(remainingLeavesProvider.notifier)
          .checkSelectedLeaveIsAvailable(
              ref.read(requestTypeValueProvider.notifier).getState(), ref);
      if (leaveAvailable!) {
        requestData.reportTo =
            ref.read(reportingToUserDetailsProvider.notifier).getState().empId;
        bool result = await ref
            .read(requestsProvider.notifier)
            .createRequest(requestData);
        // requestData.toDate = ref.read(ToDateProvider.notifier).getState();
        if (result) {
          var snackBar = customShakingSnackBarWidget(
            content: const Text("Successfully Submitted..!!!"),
            backgroundColor: Colors.green, // Background color of the snackBar
          );
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          UserData userData =
              ref.read(currentLoggedInUserDetailsProvider.notifier).getState();
          await ref.read(notificationsProvider.notifier).createNotification(
              NotificationModel(
                  1,
                  userData.empId,
                  userData.name,
                  ref.read(requestTypeValueProvider),
                  1,
                  requestData.reason,
                  DateTime.now(),
                  false,
                  null));
          if (mounted) {
            Navigator.pop(context);
          }
        } else {
          var snackBar = customShakingSnackBarWidget(
            content: const Text("Something Went Wrong Try Again..."),
            backgroundColor: Colors.red, // Background color of the snackBar
          );
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        }
      } else {
        var snackBar = customShakingSnackBarWidget(
          content: const Text("No Available Leave for Selected Type..!!!"),
          backgroundColor:
              Colors.blue.shade900, // Background color of the snackBar
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fromTime = ref.watch(fromTimeProvider);
    final toTime = ref.watch(toTimeProvider);
    final fromDate = ref.watch(fromDateProvider);
    final toDate = ref.watch(toDateProvider);
    final permissionClicked = ref.watch(permissionNotifyProvider);

    return Scaffold(
      body: Stack(
        children: [
          const MainAppBarWidget(),
          const AppBarWidget(),
          Container(
            margin: const EdgeInsets.only(top: 145),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20), topEnd: Radius.circular(20)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequestTitleTextFieldWidget(
                        labelText: "Request Title",
                        textEditingController: _requestTextController,
                      ),
                      const DropDownWidget(),
                      ProjectNameTextFieldWidget(
                        labelText: "Project Name",
                        textEditingController: _projectNameController,
                      ),
                      TeamIdTextFieldWidget(
                        labelText: "Team ID",
                        textEditingController: _teamIdController,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Text(
                          "From Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // From date
                      GestureDetector(
                        onTap: () {
                          openFromDatePicker();
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 10),
                            child: fromDateChanged == true
                                ? Text(
                                    targetDateFormat.format(fromDate),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                : const Text(
                                    "From Date",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                          ),
                        ),
                      ),
                      !permissionClicked
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10),
                              child: Text(
                                "To Date",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox(),
                      !permissionClicked
                          ? GestureDetector(
                              onTap: () {
                                openToDatePicker();
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 10),
                                  child: toDateChanged == true
                                      ? Text(
                                          targetDateFormat.format(toDate),
                                          style: const TextStyle(fontSize: 20),
                                        )
                                      : const Text(
                                          "To Date",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      permissionClicked
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10),
                              child: Text(
                                "From Time",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox(),
                      permissionClicked
                          ? GestureDetector(
                              onTap: () {
                                openFromTimePicker(context);
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 10),
                                  child: fromTimeChanged == true
                                      ? Text(convertTimeOfDayToString(fromTime))
                                      : const Text(
                                          "from Time",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      // To Time Setup
                      permissionClicked
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10),
                              child: Text(
                                "To Time",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox(),
                      permissionClicked
                          ? GestureDetector(
                              onTap: () {
                                openToTimePicker(context);
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 10),
                                  child: toTimeChanged == true
                                      ? Text(convertTimeOfDayToString(toTime))
                                      : const Text(
                                          "To Time",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      TextAreaWidget(
                        textEditingController: _reasonTextController,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 40, top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(permissionNotifyProvider.notifier).setState();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600),
                  child: const Center(
                      child: Text(
                    "Cancel",
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
                padding: const EdgeInsets.only(right: 40.0, left: 20, top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    submitRequestData();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900),
                  child: const Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )),
                ),
              ),
              label: ""),
        ],
      ),
    );
  }
}
