import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/page_navigation_state.dart';
import 'package:leave_tracker_application/src/presentation/view/create_request_page.dart';
import 'package:leave_tracker_application/src/presentation/view/home_page.dart';
import 'package:leave_tracker_application/src/presentation/view/notification_page.dart';
import 'package:leave_tracker_application/src/presentation/view/profile_page.dart';
import 'package:leave_tracker_application/src/presentation/view/timesheet_page.dart';
import 'package:leave_tracker_application/src/presentation/widgets/bottom_navigation_bar_widget.dart';

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
      body: _pages[index],
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
