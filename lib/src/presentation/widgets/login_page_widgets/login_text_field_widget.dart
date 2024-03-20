import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/login_page_state.dart';

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
              "Enter you email",
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: widget.emailController,
            onChanged: (value) {
              ref.read(loginPageEmailProvider.notifier).setState(value);
            },
            decoration: InputDecoration(
              labelText: 'Email',
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
              "Enter you Password",
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: widget.passwordController,
            onChanged: (value) {
              ref.read(loginPagePasswordProvider.notifier).setState(value);
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
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