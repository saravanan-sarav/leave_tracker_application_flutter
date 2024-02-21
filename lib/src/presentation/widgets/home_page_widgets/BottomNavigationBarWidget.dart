import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      selectedFontSize: 10,
      elevation: 10.0,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
          tooltip: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined), label: "TimeSheets"),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(), // Empty placeholder
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined), label: "Notifications"),
        BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "Profile"),
      ],
    );
  }
}
