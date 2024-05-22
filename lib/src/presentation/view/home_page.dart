import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/presentation/view/profile_page.dart';
import 'package:leave_tracker_application/src/presentation/widgets/home_page_widgets/create_request.dart';
import 'package:leave_tracker_application/src/presentation/widgets/home_page_widgets/list_of_request.dart';
import 'package:leave_tracker_application/src/utils/constants/date_parser.dart';

import '../providers/user_providers/current_logged_in_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserData currentLoggedInUser =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState();
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: 110,
            width: double.infinity,
            color: Colors.blue[900],
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentLoggedInUser.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "@${currentLoggedInUser.designation} - ${currentLoggedInUser.domain}",
                          style: const TextStyle(
                            color: Colors.white24,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/profile_picture.jpeg'),
                              fit: BoxFit.fill
                              // Provide your image path here
                              ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Hi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue.shade900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            "${currentLoggedInUser.name},",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue.shade900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            "Good ${getTimeOfDayPeriod(DateTime.now())} . . .",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue.shade900),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, bottom: 20),
                      child: Text(
                        "Have a nice day...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  const CreateRequestWidget(),
                  const ListOfRequestWidget()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
