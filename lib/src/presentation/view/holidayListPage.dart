import 'package:flutter/material.dart';

class HolidayListPage extends StatefulWidget {
  const HolidayListPage({super.key});

  @override
  State<HolidayListPage> createState() => _HolidayListPageState();
}

class _HolidayListPageState extends State<HolidayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),body: Center(child: Text("Holiday List Page"),));
  }
}
