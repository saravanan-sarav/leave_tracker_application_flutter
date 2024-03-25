import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/current_logged_in_user.dart';
import 'package:leave_tracker_application/src/presentation/state_management/permission_notifier.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/appbar_widget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/drop_down_widget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/text_field_widget.dart';

import '../../domain/models/request.dart';

class CreateRequestPage extends ConsumerStatefulWidget {
  const CreateRequestPage({super.key});

  @override
  ConsumerState<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends ConsumerState<CreateRequestPage> {
  final TextEditingController _requestTextController = TextEditingController();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _teamIdController = TextEditingController();
  final TextEditingController _reasonTextController = TextEditingController();
  final TextEditingController _fromDateTextController = TextEditingController();
  final TextEditingController _toDateTextController = TextEditingController();
  final TextEditingController _fromTimeTextController = TextEditingController();
  final TextEditingController _toTimeTextController = TextEditingController();
  final TextEditingController _requestTypeTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  submitRequestData() async {
    bool validationSuccessful = false;
    RequestData requestData = RequestData(
        0,
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
  }

  @override
  Widget build(BuildContext context) {
    final permissionClicked = ref.watch(permissionNotifyProvider);
    final _formKey = GlobalKey<FormState>();
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
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequestTitleTextFieldWidget(
                        labelText: "Request Title",
                        textEditingController: _requestTextController,
                      ),
                      DropDownWidget(_requestTypeTextController),
                      ProjectNameTextFieldWidget(
                        labelText: "Project Name",
                        textEditingController: _projectNameController,
                      ),
                      TeamIdTextFieldWidget(
                        labelText: "Team ID",
                        textEditingController: _teamIdController,
                      ),
                      // From date
                      FromDateTextFieldWidget(
                        labelText: "From Date",
                        textEditingController: _fromDateTextController,
                      ),
                      !permissionClicked
                          ? ToDateTextFieldWidget(
                              labelText: "To Date",
                              toDateTextEditingController:
                                  _toDateTextController,
                              fromDateTextEditingController:
                                  _fromDateTextController,
                            )
                          : const SizedBox(),

                      permissionClicked
                          ? FromTimeTextFieldWidget(
                              textEditingController: _fromTimeTextController,
                              labelText: "From Time",
                            )
                          : const SizedBox(),
                      // To Time Setup
                      permissionClicked
                          ? ToTimeTextFieldWidget(
                              fromTimeTextEditingController:
                                  _fromTimeTextController,
                              labelText: "To Time",
                              toTimeTextEditingController:
                                  _toTimeTextController,
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
                    _formKey.currentState!.validate();
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
