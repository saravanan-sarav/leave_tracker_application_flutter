import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginEmailTextFieldWidget extends ConsumerStatefulWidget {
  final TextEditingController emailController;

  const LoginEmailTextFieldWidget(this.emailController, {super.key});

  @override
  ConsumerState<LoginEmailTextFieldWidget> createState() =>
      _LoginEmailTextFieldWidgetState();
}

class _LoginEmailTextFieldWidgetState
    extends ConsumerState<LoginEmailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.enter_your_email,
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: widget.emailController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.email,
              labelStyle: TextStyle(color: Colors.blue.shade900),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            style: const TextStyle(color: Colors.lightBlue),
            cursorColor: Colors.lightBlue,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class LoginPasswordTextFieldWidget extends ConsumerStatefulWidget {
  final TextEditingController passwordController;

  const LoginPasswordTextFieldWidget(this.passwordController, {super.key});

  @override
  ConsumerState<LoginPasswordTextFieldWidget> createState() =>
      _LoginPasswordTextFieldWidgetState();
}

class _LoginPasswordTextFieldWidgetState
    extends ConsumerState<LoginPasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              AppLocalizations.of(context)!.enter_your_password,
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: widget.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.password,
              labelStyle: TextStyle(color: Colors.blue.shade900),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade900),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            style: TextStyle(color: Colors.lightBlue.shade300),
            cursorColor: Colors.lightBlue,
          ),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
