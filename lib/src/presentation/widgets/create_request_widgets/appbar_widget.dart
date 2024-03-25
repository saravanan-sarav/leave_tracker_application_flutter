import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/permission_notifier.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(20), topEnd: Radius.circular(20)),
        color: Colors.lightBlue.shade300,
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 15.0, top: 10),
        child: Text(
          "Create New Request",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MainAppBarWidget extends ConsumerStatefulWidget {
  const MainAppBarWidget({super.key});

  @override
  ConsumerState<MainAppBarWidget> createState() => _MainAppBarWidgetState();
}

class _MainAppBarWidgetState extends ConsumerState<MainAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.blue.shade900,
      child: Padding(
        padding: const EdgeInsets.only(top: 45.0, right: 20, left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                ref.read(permissionNotifyProvider.notifier).setState();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Apply Leave",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info_rounded,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
