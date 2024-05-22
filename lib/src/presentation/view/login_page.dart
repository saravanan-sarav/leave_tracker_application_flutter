import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/app.dart';
import 'package:leave_tracker_application/src/presentation/providers/user_providers/user_provider.dart';
import 'package:leave_tracker_application/src/presentation/state_management/loading_provider.dart';
import 'package:leave_tracker_application/src/presentation/widgets/login_page_widgets/login_text_field_widget.dart';
import 'package:leave_tracker_application/src/utils/extensions/connectivity.dart';

import '../../domain/models/localization.dart';
import '../providers/localization_provider.dart';
import '../state_management/localization_state.dart';
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
    final loader = ref.read(loadingProvider.notifier);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.blue.shade900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 120.0),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          child: Image(
                              image: AssetImage(
                                  "assets/images/kumaran-systems-logo.png")),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 10),
                      child: Text(
                        AppLocalizations.of(context)!.welcome_back,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 14),
                      child: Text(
                        AppLocalizations.of(context)!.welcome_note,
                        style: TextStyle(
                            color: Colors.lightBlue.shade200,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 500.0, left: 14),
                      child: Text(
                        "Copyright © 2024 Kumaran Systems Pvt Ltd"
                        ". All rights reserved.",
                        style: TextStyle(
                            color: Colors.lightBlue.shade200, fontSize: 15),
                      ),
                    ),
                  ],
                )),
          ),
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                margin: const EdgeInsets.only(top: 300, right: 10, left: 10),
                height: 360,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Form(
                        // key: loginFormKey,
                        child: Column(
                      children: [
                        LoginEmailTextFieldWidget(emailTextController),
                        LoginPasswordTextFieldWidget(passwordTextController),
                      ],
                    )),
                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         var snackBar = customShakingSnackBarWidget(
                    //           content:
                    //               const Text("Please Contact Admin Team..!!!"),
                    //           backgroundColor: Colors
                    //               .red, // Background color of the snackBar
                    //         );
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(snackBar);
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 15.0),
                    //         child: Text(
                    //           AppLocalizations.of(context)!.forget_password,
                    //           style: const TextStyle(
                    //               color: Colors.red,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 50,
                        width: 140,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (emailTextController.text.isEmpty &&
                                  passwordTextController.text.isEmpty) {
                                var snackBar = customShakingSnackBarWidget(
                                  content: const Text("Enter Credentials..."),
                                  backgroundColor: Colors.red,
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                if (await checkUserConnection()) {
                                  loader.startLoading();
                                  final result = await ref
                                      .read(authUserDetailsProvider.notifier)
                                      .authUserDetails(emailTextController.text,
                                          passwordTextController.text);
                                  if (result) {
                                    if (context.mounted) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage()));
                                    }
                                    loader.endLoading();
                                  } else {
                                    loader.endLoading();
                                    var snackBar = customShakingSnackBarWidget(
                                      content:
                                          const Text("Invalid Credentials..."),
                                      backgroundColor: Colors.red,
                                    );
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                } else {
                                  var snackBar = customShakingSnackBarWidget(
                                    content: const Text(
                                        "Check Internet connection..."),
                                    backgroundColor: Colors.red,
                                  );
                                  if (context.mounted) {
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
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          onPressed: () async {
            Future<bool?> dialogBuilder(BuildContext context, WidgetRef ref) {
              List<Localization> localizations =
                  ref.read(localizationsProvider.notifier).getLocalizations();
              return showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.blue[700],
                    title: const Text(
                      "select Language",
                      style: TextStyle(color: Colors.white),
                    ),
                    // Adjust spacing as needed
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: localizations.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () async {
                                        ref
                                            .read(localizationProvider.notifier)
                                            .changeLocale(localizations[index]);
                                        Navigator.pop(context);
                                      },
                                      title: Text(
                                        localizations[index].language,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            await dialogBuilder(context, ref);
            setState(() {});
          },
          child: const Icon(
            Icons.language,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
