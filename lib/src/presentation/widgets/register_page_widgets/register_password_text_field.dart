import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordField extends ConsumerStatefulWidget {
  final TextEditingController passwordController;
  final String labelText;

  const PasswordField(this.passwordController, this.labelText, {super.key});

  @override
  ConsumerState<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends ConsumerState<PasswordField> {
  bool hidePasswordText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.passwordController,
            obscureText: hidePasswordText,
            decoration: InputDecoration(
              suffixIcon: hidePasswordText
                  ? IconButton(
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        hidePasswordText = !hidePasswordText;
                        setState(() {});
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        hidePasswordText = !hidePasswordText;
                        setState(() {});
                      },
                    ),
              labelText: "Password",
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }

              final RegExp passwordRegex = RegExp(
                  r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,16}$');
              if (!passwordRegex.hasMatch(value)) {
                return 'Password must be 8-16 characters long, \ninclude an uppercase letter, a number, and a symbol.';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class ConfirmPasswordField extends ConsumerStatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String labelText;

  const ConfirmPasswordField(
      this.confirmPasswordController, this.passwordController, this.labelText,
      {super.key});

  @override
  ConsumerState<ConfirmPasswordField> createState() =>
      _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends ConsumerState<ConfirmPasswordField> {
  bool hidePasswordText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.confirmPasswordController,
            obscureText: hidePasswordText,
            decoration: InputDecoration(
              suffixIcon: hidePasswordText
                  ? IconButton(
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        hidePasswordText = !hidePasswordText;
                        setState(() {});
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        hidePasswordText = !hidePasswordText;
                        setState(() {});
                      },
                    ),
              labelText: widget.labelText,
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Password';
              }
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
