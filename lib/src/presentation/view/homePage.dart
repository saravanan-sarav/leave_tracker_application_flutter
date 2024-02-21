import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/localizationState.dart';
import 'package:leave_tracker_application/src/presentation/widgets/BottomNavigationBarWidget.dart';
import 'package:leave_tracker_application/src/presentation/widgets/home_page_widgets/CreateRequest.dart';
import 'package:leave_tracker_application/src/presentation/widgets/home_page_widgets/ListOfRequest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Container(
            height: 135,
            width: double.infinity,
            color: Colors.blue[900],
            child: const Padding(
              padding: EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saravanan S",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "@Intern - Banking",
                          style: TextStyle(
                            color: Colors.white24,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/images/profile_picture.jpeg'),
                    // Background color of the avatar
                    foregroundImage: AssetImage(
                        'assets/images/profile_picture.jpeg'), // Path to your image asset
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 13),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.cyan,
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.timesheet,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                const Text(
                                  "Follow Up,Check Attendance Details,...",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                CreateRequestWidget(),
                ListOfRequestWidget()
              ],
            ),
          )
        ],
      ),

    );
  }
}
