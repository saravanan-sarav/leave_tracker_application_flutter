import 'package:flutter/material.dart';

class RemainingLeavePage extends StatefulWidget {
  const RemainingLeavePage({super.key});

  @override
  State<RemainingLeavePage> createState() => _RemainingLeavePageState();
}

class _RemainingLeavePageState extends State<RemainingLeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Remaining Leave Pages"),
      ),
    );
  }
}
