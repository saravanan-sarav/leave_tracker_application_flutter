import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/app.dart';
import 'package:leave_tracker_application/src/domain/models/currentLoggedInUser.dart';
import 'package:leave_tracker_application/src/domain/models/userDetailsModel.dart';
import 'package:leave_tracker_application/src/presentation/state_management/loginPageState.dart';
import 'package:leave_tracker_application/src/presentation/widgets/login_page_widgets/LoginTextFieldWidget.dart';

import '../widgets/SnakeBarWidget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
                          fontSize: 18),
                    ),
                  ),
                ],
              )),
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                margin: const EdgeInsets.only(top: 290, right: 10, left: 10),
                height: MediaQuery.of(context).size.height * 0.41,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    LoginEmailTextFieldWidget(),
                    LoginPasswordTextFieldWidget(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            var snackbar = customShakingSnackBarWidget(
                              content:
                                  const Text("Please Contact Admin Team..!!!"),
                              backgroundColor: Colors
                                  .red, // Background color of the snackbar
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
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
                            onPressed: () {
                              String email = ref
                                  .read(loginPageEmailProvider.notifier)
                                  .getState();
                              String password = ref
                                  .read(loginPagePasswordProvider.notifier)
                                  .getState();
                              UserData? authUser =
                                  isUserIsValid(email, password);
                              if (authUser != null) {
                                setCurrentLoggedInUser(authUser);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              } else {
                                if (email == "" || password == "") {
                                  var snackbar = customShakingSnackBarWidget(
                                    content:
                                        const Text("Enter  Credentials..!!!"),
                                    backgroundColor: Colors
                                        .yellow, // Background color of the snackbar
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else {
                                  var snackbar = customShakingSnackBarWidget(
                                    content:
                                        const Text("Invalid Credentials..!!!"),
                                    backgroundColor: Colors
                                        .red, // Background color of the snackbar
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
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
