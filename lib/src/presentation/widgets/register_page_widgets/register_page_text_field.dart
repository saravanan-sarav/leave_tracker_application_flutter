import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/widgets/create_request_widgets/date_time_picker_widget.dart';
import 'package:leave_tracker_application/src/utils/constants/default_values.dart';
import 'package:leave_tracker_application/src/utils/constants/models.dart';

import '../../providers/register_providers/register_provider.dart';

class NameTextField extends ConsumerStatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const NameTextField(
      {super.key,
      required this.labelText,
      required this.textEditingController});

  @override
  ConsumerState<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends ConsumerState<NameTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
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
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value == "") {
                return "Enter you Full Name";
              }
            },
          ),
        ],
      ),
    );
  }
}

class DateOfBirthTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const DateOfBirthTextField({
    super.key,
    required this.labelText,
    required this.textEditingController,
  });

  @override
  State<DateOfBirthTextField> createState() => _DateOfBirthTextFieldState();
}

class _DateOfBirthTextFieldState extends State<DateOfBirthTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.textEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 320,
                            child: FromDatePickerWidget(
                                widget.textEditingController));
                      });
                },
              ),
              // errorText: isValid ? "Please enter From Date." : null,
              hintText: "dd-mm-yyyy",
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
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a date';
              }
              if (value.length == 2 || value.length == 5) {
                widget.textEditingController.text = "$value-";
              }
              final RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');

              if (!dateRegex.hasMatch(value)) {
                return 'Enter a valid date in MM-DD-YYYY format';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class JoinedDateTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const JoinedDateTextField({
    super.key,
    required this.labelText,
    required this.textEditingController,
  });

  @override
  State<JoinedDateTextField> createState() => _JoinedDateTextFieldState();
}

class _JoinedDateTextFieldState extends State<JoinedDateTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.textEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 320,
                            child: FromDatePickerWidget(
                                widget.textEditingController));
                      });
                },
              ),
              // errorText: isValid ? "Please enter From Date." : null,
              hintText: "dd-mm-yyyy",
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
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a date';
              }
              if (value.length == 2 || value.length == 5) {
                widget.textEditingController.text = "$value-";
              }
              final RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');

              if (!dateRegex.hasMatch(value)) {
                return 'Enter a valid date in MM-DD-YYYY format';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class GenderTextField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;

  const GenderTextField(this.textEditingController, {super.key});

  @override
  ConsumerState<GenderTextField> createState() => _GenderTextFieldState();
}

class _GenderTextFieldState extends ConsumerState<GenderTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
          child: Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField<String>(
            // enableFeedback: false,
            hint: const Text('Select Gender'),
            decoration: InputDecoration(
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
            items: gender.map<DropdownMenuItem<String>>((Gender gen) {
              return DropdownMenuItem<String>(
                value: gen.name,
                child: Row(
                  children: [
                    Icon(
                      gen.icon,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(gen.name),
                    )
                  ],
                ),
              );
            }).toList(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return 'Please select Gender';
              }
              return null;
            },
            onChanged: (String? value) {
              widget.textEditingController.text = value!;
            },
          ),
        ),
      ],
    );
  }
}

class DomainField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;

  const DomainField(this.textEditingController, {super.key});

  @override
  ConsumerState<DomainField> createState() => _DomainFieldState();
}

class _DomainFieldState extends ConsumerState<DomainField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
          child: Text(
            "Domain",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField<String>(
            // enableFeedback: false,
            hint: const Text('Select Domain'),
            decoration: InputDecoration(
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
            items: domain.map<DropdownMenuItem<String>>((Domain gen) {
              return DropdownMenuItem<String>(
                value: gen.domain,
                child: Row(
                  children: [
                    Icon(
                      gen.icon,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(gen.domain),
                    )
                  ],
                ),
              );
            }).toList(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return 'Please select Domain';
              }
              return null;
            },
            onChanged: (String? value) {
              widget.textEditingController.text = value!;
            },
          ),
        ),
      ],
    );
  }
}

class DesignationField extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;

  const DesignationField(this.textEditingController, {super.key});

  @override
  ConsumerState<DesignationField> createState() => _DesignationFieldState();
}

class _DesignationFieldState extends ConsumerState<DesignationField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
          child: Text(
            "Designation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField<String>(
            // enableFeedback: false,
            hint: const Text('Select Designation'),
            decoration: InputDecoration(
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
            items:
                designations.map<DropdownMenuItem<String>>((Designation gen) {
              return DropdownMenuItem<String>(
                value: gen.designation,
                child: Row(
                  children: [
                    Icon(
                      gen.icon,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(gen.designation),
                    )
                  ],
                ),
              );
            }).toList(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return 'Please select Designation';
              }
              return null;
            },
            onChanged: (String? value) {
              widget.textEditingController.text = value!;
            },
          ),
        ),
      ],
    );
  }
}

class EmailField extends ConsumerStatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  EmailField(
      {super.key,
      required this.labelText,
      required this.textEditingController});

  @override
  ConsumerState<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends ConsumerState<EmailField> {
  bool _isLoading = false;
  bool? _isEmailValid;

  Future<void> _checkEmailExists(String email) async {
    _isLoading = true;
    _isEmailValid = null;
    setState(() {});
    _isEmailValid =
        await ref.read(checkEmailExistsProvider.notifier).checkEmail(email);
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              suffixIcon: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      ),
                    )
                  : _isEmailValid == null
                      ? null
                      : Icon(
                          _isEmailValid! ? Icons.check_circle : Icons.error,
                          color: _isEmailValid! ? Colors.green : Colors.red,
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
            cursorColor: Colors.grey,
            onChanged: (value) {
              final RegExp emailRegex =
                  RegExp(r'''^[a-zA-Z.!#$%&'*+/=?^_`{|}~-]+@kumaran\.com$''');
              if (emailRegex.hasMatch(value)) {
                _checkEmailExists(value);
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              } else {
                final RegExp emailRegex =
                    RegExp(r'''^[a-zA-Z.!#$%&'*+/=?^_`{|}~-]+@kumaran\.com$''');
                if (!emailRegex.hasMatch(value)) {
                  return "Enter Correct organization mail...";
                } else {
                  if (!_isLoading && !_isEmailValid!) {
                    return "Email Already Exists. Try another";
                  }
                }
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
