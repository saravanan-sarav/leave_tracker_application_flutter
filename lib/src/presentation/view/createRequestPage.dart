import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/DropDownWidget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/TextFieldWidget.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  @override
  Widget build(BuildContext context) {
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
            child: const Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFieldWidget(labelText: "Request Title",),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: TextFieldWidget(labelText: "Request Type",),
                    ),
                    DropDownWidget(), 
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
