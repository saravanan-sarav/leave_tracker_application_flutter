import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/app.dart';
import 'package:leave_tracker_application/src/domain/models/user.dart';
import 'package:leave_tracker_application/src/presentation/providers/holidays_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/notification_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/remaining_leave_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/request_provider.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/loading_provider.dart';
import 'package:leave_tracker_application/src/presentation/widgets/login_page_widgets/login_text_field_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../widgets/snack_bar_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.blue.shade900,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 200.0, left: 10),
                    child: Text(
                      "Welcome Back..!!!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 14),
                    child: Text(
                      "Automate your leave requests with just one click!",
                      style: TextStyle(
                          color: Colors.lightBlue.shade200,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              )),
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                margin: const EdgeInsets.only(top: 290, right: 10, left: 10),
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    LoginEmailTextFieldWidget(emailTextController),
                    LoginPasswordTextFieldWidget(passwordTextController),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.loaderOverlay.show();
                            var snackBar = customShakingSnackBarWidget(
                              content:
                                  const Text("Please Contact Admin Team..!!!"),
                              backgroundColor: Colors
                                  .red, // Background color of the snackBar
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () async {
                              ref.read(loadingProvider.notifier).startLoading();
                              final String email = emailTextController.text;
                              final String password =
                                  passwordTextController.text;
                              await ref
                                  .read(authUserDetailsProvider.notifier)
                                  .authUserDetails(email, password);
                              final authUser =
                                  ref.read(authUserDetailsProvider.notifier);
                              if (authUser.getAuthUserDetails() is UserData) {
                                final currentLoggedInUserDetails = ref.read(
                                    currentLoggedInUserDetailsProvider
                                        .notifier);
                                currentLoggedInUserDetails
                                    .setState(authUser.getAuthUserDetails());
                                ref
                                    .read(
                                        reportingToUserDetailsProvider.notifier)
                                    .getReportingToUserDetails(
                                        currentLoggedInUserDetails
                                            .getState()
                                            .reportingTo);
                                authUser.clearAuthData();
                                await ref
                                    .read(holidaysProvider.notifier)
                                    .getAllHolidays();
                                await ref
                                    .read(requestsProvider.notifier)
                                    .getUserRequests(ref);
                                await ref
                                    .read(requestSentToMeProvider.notifier)
                                    .getSentToMeRequestList(ref);
                                await ref
                                    .read(remainingLeavesProvider.notifier)
                                    .getAllRemainingLeave(ref);
                                await ref
                                    .read(notificationsProvider.notifier)
                                    .getAllNotifications(ref);
                                await ref
                                    .read(notificationActionProvider.notifier)
                                    .getNotificationActions();
                                ref.read(loadingProvider.notifier).endLoading();
                                await ref
                                    .read(requestTypesProvider.notifier)
                                    .getRequestType();
                                if(mounted){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const MyHomePage()));
                                }
                                ref.read(loadingProvider.notifier).endLoading();
                              } else {
                                ref.read(loadingProvider.notifier).endLoading();
                                if (email == "" || password == "") {
                                  var snackBar = customShakingSnackBarWidget(
                                    content:
                                        const Text("Enter  Credentials..!!!"),
                                    backgroundColor: Colors
                                        .yellow,
                                  );
                                  if(mounted){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  ref
                                      .read(loadingProvider.notifier)
                                      .endLoading();

                                  var snackBar = customShakingSnackBarWidget(
                                    content: Text(
                                        "${ref.read(authUserDetailsProvider.notifier).getAuthUserDetails()}"),
                                    backgroundColor: Colors
                                        .red,
                                  );
                                  if(mounted){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
