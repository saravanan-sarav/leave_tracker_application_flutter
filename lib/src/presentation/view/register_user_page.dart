import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/presentation/widgets/register_page_widgets/register_page_text_field.dart';
import 'package:leave_tracker_application/src/presentation/widgets/register_page_widgets/register_password_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController joinedDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.blue.shade900,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Enroll Employee",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 20),
                    child: IconButton(
                      onPressed: () {
                        if (registerFormKey.currentState!.validate()) {}
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: registerFormKey,
                child: Column(
                  children: [
                    NameTextField(
                        labelText: "Full Name",
                        textEditingController: nameController),
                    DateOfBirthTextField(
                        labelText: "Date Of Birth",
                        textEditingController: dateOfBirthController),
                    JoinedDateTextField(
                        labelText: "Joined Date",
                        textEditingController: joinedDateController),
                    GenderTextField(genderController),
                    DomainField(domainController),
                    DesignationField(designationController),
                    EmailField(
                        labelText: "Email",
                        textEditingController: emailController),
                    PasswordField(passwordController, "Password"),
                    ConfirmPasswordField(confirmPasswordController,
                        passwordController, "Confirm Password")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
