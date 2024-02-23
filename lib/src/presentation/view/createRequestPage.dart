import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leave_tracker_application/src/presentation/state_management/FromTimeToTimeState.dart';
import 'package:leave_tracker_application/src/presentation/state_management/createRequestSubmitState.dart';
import 'package:leave_tracker_application/src/presentation/state_management/dateChecker.dart';
import 'package:leave_tracker_application/src/presentation/state_management/requestTypeState.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/AppbarWidget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/DateTimePickerWidget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/DropDownWidget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/TextFieldWidget.dart';

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

  TextEditingController _requestTextController = TextEditingController();
  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _teamIdController = TextEditingController();
  TextEditingController _reasonTextController = TextEditingController();

  final String originalDateTimeString = "2024-02-22 16:55:25.081174";
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
    print(ref.watch(fromTimeProvider));
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
    print("Formatted Date $formattedTime");
    return formattedTime;
  }

  bool _requestTittleFilled = false;
  bool _requestTypeFilled = false;
  bool _projectNameFilled = false;
  bool _teamIdFilled = false;
  bool _fromDateFilled = false;
  bool _toDateFilled = false;
  bool _reasonFilled = false;
  bool _fromTimeFilled = false;
  bool _toTimeFilled = false;

  @override
  void initState() {
    super.initState();
    _requestTextController.addListener(checkAllFieldAreFilled);
    _reasonTextController.addListener(checkAllFieldAreFilled);
    _teamIdController.addListener(checkAllFieldAreFilled);
    _reasonTextController.addListener(checkAllFieldAreFilled);
  }

  checkAllFieldAreFilled() {
    setState(() {
      _requestTittleFilled = _requestTextController.text.isNotEmpty;
      _projectNameFilled = _reasonTextController.text.isNotEmpty;
      _teamIdFilled = _teamIdController.text.isNotEmpty;

    });
  }

  submitRequestData() {}

  @override
  Widget build(BuildContext context) {
    final fromTime = ref.watch(fromTimeProvider);
    final toTime = ref.watch(toTimeProvider);
    final fromDate = ref.watch(fromDateProvider);
    final toDate = ref.watch(ToDateProvider);
    final permissionClicked = ref.watch(permissionNotifyProvider);

    final submitButtonIsValid =
        ref.watch(createRequestButtonValidationProvider);
    return Scaffold(
      body: Stack(
        children: [
          MainAppBarWidget(),
          AppBarWidget(),
          Container(
            margin: EdgeInsets.only(top: 145),
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequestTitleTextFieldWidget(
                        labelText: "Request Title",
                        textEditingController: _requestTextController,
                      ),
                      DropDownWidget(),
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
                                    style: TextStyle(fontSize: 20),
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
                                          style: TextStyle(fontSize: 20),
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
                          : SizedBox(),
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
                  onPressed: submitButtonIsValid
                      ? () {
                          submitRequestData();
                        }
                      : null,
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
