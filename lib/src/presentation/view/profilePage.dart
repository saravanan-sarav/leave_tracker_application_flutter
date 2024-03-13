import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/domain/models/notification.dart';
import 'package:leave_tracker_application/src/presentation/providers/userProvider.dart';
import 'package:leave_tracker_application/src/presentation/view/loginPage.dart';
import 'package:leave_tracker_application/src/utils/constants/dateParser.dart';

import '../../utils/constants/TimeParser.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Color _backgroundColor = Colors.white;
  bool isTappedCheck = false;

  void _changeBackgroundColor(bool isTapped) {
    setState(() {
      isTappedCheck = isTapped;
      _backgroundColor = isTapped ? Colors.red : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLoggedInUser =
        ref.read(currentLoggedInUserDetailsProvider.notifier).getState();
    final currentUserReportingUserDetail =
        ref.read(reportingToUserDetailsProvider.notifier).getState();
    return Material(
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.blue.shade900,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 90),
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 30, right: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              foregroundImage: AssetImage(
                                  "assets/images/profile_picture.jpeg"),
                              radius: 30,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          currentLoggedInUser.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      currentLoggedInUser.email,
                                      style: TextStyle(
                                          color: Colors.blue.shade200,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Joined at : ",
                                style: TextStyle(
                                    color: Colors.blue.shade200,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                "${formatDateAsNumber(currentLoggedInUser.joiningDate)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                "  (${formatTimeAgo(currentLoggedInUser.joiningDate)})",
                                style: TextStyle(
                                    color: Colors.blue.shade500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Position : ",
                                style: TextStyle(
                                    color: Colors.blue.shade200,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                "@${currentLoggedInUser.designation} - ${currentLoggedInUser.domain}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, bottom: 8, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Reporting To",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              foregroundImage: AssetImage(
                                  "assets/images/profile_picture.jpeg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${currentUserReportingUserDetail.name}",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${currentUserReportingUserDetail.designation} - ${currentUserReportingUserDetail.domain}",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 2,
                  width: double.infinity,
                  color: Colors.lightBlue,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Preferences",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Current UnAvailable",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Account",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Switch Account",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Current UnAvailable",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            onTapDown: (_) {
                              _changeBackgroundColor(true);
                            },
                            onTapUp: (_) {
                              _changeBackgroundColor(false);
                            },
                            onTapCancel: () {
                              _changeBackgroundColor(false);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 40),
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: _backgroundColor,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Center(
                                child: isTappedCheck
                                    ? const Text(
                                        'Log Out',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    : const Text(
                                        'Log Out',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
