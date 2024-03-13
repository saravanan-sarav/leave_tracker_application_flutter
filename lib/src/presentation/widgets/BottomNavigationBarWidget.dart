import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/notificationBadgeState.dart';
import 'package:leave_tracker_application/src/presentation/state_management/pageNavigationState.dart';

class BottomNavigationBarWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  ConsumerState<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarWidget> {
  void _onItemTapped(int index) {
    print(index);
    setState(() {
      ref.read(pageNavigatorProvider.notifier).changeNavigationPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: ref.watch(pageNavigatorProvider.notifier).getState(),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      selectedFontSize: 10,
      elevation: 0,
      onTap: _onItemTapped,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
          tooltip: "Home",
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined), label: "TimeSheets"),
        const BottomNavigationBarItem(
          icon: SizedBox.shrink(), // Empty placeholder
          label: '',
        ),
        BottomNavigationBarItem(
            icon: ref.watch(notificationBadgeProvider) != 0
                ? badges.Badge(
                    badgeContent: Text(
                      "${ref.watch(notificationBadgeProvider)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                    ),
                  )
                : const Icon(
                    Icons.notifications_outlined,
                  ),
            label: "Notifications"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined), label: "Profile"),
      ],
    );
  }
}
