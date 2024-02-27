import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/pageNavigationState.dart';
import 'package:leave_tracker_application/src/presentation/view/createRequestPage.dart';
import 'package:leave_tracker_application/src/presentation/view/homePage.dart';
import 'package:leave_tracker_application/src/presentation/view/notificationPage.dart';
import 'package:leave_tracker_application/src/presentation/view/profilePage.dart';
import 'package:leave_tracker_application/src/presentation/view/timesheetPage.dart';
import 'package:leave_tracker_application/src/presentation/widgets/BottomNavigationBarWidget.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final List<Widget> _pages = [
    const HomePage(),
    const TimesheetPageWidget(),
    const Center(),
    const NotificationPageWidget(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    var index = ref.watch(pageNavigatorProvider);
    return Scaffold(
      body: _pages[index as int],
      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateRequestPage()))
        },
        backgroundColor: Colors.cyan,
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
