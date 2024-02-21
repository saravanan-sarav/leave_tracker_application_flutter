import 'package:flutter/material.dart';

class TimesheetPageWidget extends StatefulWidget {
  const TimesheetPageWidget({super.key});

  @override
  State<TimesheetPageWidget> createState() => _TimesheetPageWidgetState();
}

class _TimesheetPageWidgetState extends State<TimesheetPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Timesheet Page"),
    );;
  }
}
