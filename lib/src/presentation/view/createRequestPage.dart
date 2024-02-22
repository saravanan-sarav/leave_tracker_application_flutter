import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leave_tracker_application/src/domain/models/dropdownItem.dart';
import 'package:leave_tracker_application/src/presentation/state_management/dateChecker.dart';
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
  DateTime? FromDate;
  final String originalDateTimeString = "2024-02-22 16:55:25.081174";
  final DateFormat originalDateFormat =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
  final DateFormat targetDateFormat = DateFormat("dd-MM-yyyy");

  void openFromDatePicker() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const SizedBox(height: 350, child: DatePickerWidget());
        });
    fromDateChanged = !fromDateChanged;
    print(ref.watch(fromDateProvider));
  }

  void openToDatePicker() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const SizedBox(height: 350, child: ToDatePickerWidget());
        });
    toDateChanged == false ? toDateChanged = true : null;
  }

  @override
  Widget build(BuildContext context) {
    final fromDate = ref.watch(fromDateProvider);
    final toDate = ref.watch(ToDateProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue.shade900,
          ),
          Container(
            margin: EdgeInsets.only(top: 70),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(20), topEnd: Radius.circular(20)),
              color: Colors.lightBlue.shade300,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 110),
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
                      const TextFieldWidget(
                        labelText: "Request Title",
                      ),
                      DropDownWidget(
                        listData: requestTypes,
                      ),
                      const TextFieldWidget(labelText: "Project Name"),
                      const TextFieldWidget(labelText: "Team ID"),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
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
                            child: Text(
                              fromDateChanged == false
                                  ? targetDateFormat.format(fromDate)
                                  : "",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Text(
                          "To Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
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
                            padding: const EdgeInsets.only(top: 20.0, left: 10),
                            child: Text(
                              toDateChanged == false
                                  ? targetDateFormat.format(toDate)
                                  : "",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
