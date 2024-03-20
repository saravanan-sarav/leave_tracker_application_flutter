import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';
import 'package:leave_tracker_application/src/presentation/view/profile_page.dart';
import 'package:leave_tracker_application/src/presentation/widgets/home_page_widgets/create_request.dart';
import 'package:leave_tracker_application/src/presentation/widgets/home_page_widgets/list_of_request.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserData currentLoggedInUser =
        ref.watch(currentLoggedInUserDetailsProvider.notifier).getState();
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: 155,
            width: double.infinity,
            color: Colors.blue[900],
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
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
              margin: const EdgeInsets.only(top: 120),
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
                        padding: const EdgeInsets.only(right: 15, left: 15),
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
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 20),
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