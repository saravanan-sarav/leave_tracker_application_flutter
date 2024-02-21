import 'package:flutter/material.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Notification Page"),
    );
  }
}
