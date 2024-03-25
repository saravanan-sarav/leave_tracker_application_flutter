import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/utils/constants/date_parser.dart';

import '../../../utils/constants/time_parser.dart';
import 'date_time_picker_widget.dart';

class RequestTitleTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const RequestTitleTextFieldWidget(
      {super.key,
      required this.labelText,
      required this.textEditingController});

  @override
  State<RequestTitleTextFieldWidget> createState() =>
      _RequestTitleTextFieldWidgetState();
}

class _RequestTitleTextFieldWidgetState
    extends State<RequestTitleTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
              if (value == null || value.isEmpty) {
                return "Please enter request Tittle";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class ProjectNameTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const ProjectNameTextFieldWidget(
      {super.key,
      required this.labelText,
      required this.textEditingController});

  @override
  State<ProjectNameTextFieldWidget> createState() =>
      _ProjectNameTextFieldWidgetState();
}

class _ProjectNameTextFieldWidgetState
    extends State<ProjectNameTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
              if (value == null || value.isEmpty) {
                return "Please enter Project Name";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class TeamIdTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const TeamIdTextFieldWidget(
      {super.key,
      required this.labelText,
      required this.textEditingController});

  @override
  State<TeamIdTextFieldWidget> createState() => _TeamIdTextFieldWidgetState();
}

class _TeamIdTextFieldWidgetState extends State<TeamIdTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
              if (value == null || value.isEmpty) {
                return "Please enter Team ID";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// Text Area Widget
class TextAreaWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const TextAreaWidget({super.key, required this.textEditingController});

  @override
  State<TextAreaWidget> createState() => _TextAreaWidgetState();
}

class _TextAreaWidgetState extends State<TextAreaWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10),
          child: Text(
            "Reasons",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: widget.textEditingController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            labelText: "Reasons (Brief)",
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
              return "Please enter Team ID";
            }
            return null;
          },
        )
      ],
    );
  }
}

class FromDateTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const FromDateTextFieldWidget({
    super.key,
    required this.labelText,
    required this.textEditingController,
  });

  @override
  State<FromDateTextFieldWidget> createState() =>
      _FromDateTextFieldWidgetState();
}

class _FromDateTextFieldWidgetState extends State<FromDateTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
                            child:
                                DatePickerWidget(widget.textEditingController));
                      });
                },
              ),
              // errorText: isValid ? "Please enter From Date." : null,
              hintText: "dd/mm/yyyy",
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
                widget.textEditingController.text = "$value/";
              }
              final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

              if (!dateRegex.hasMatch(value)) {
                return 'Enter a valid date in MM/DD/YYYY format';
              }

              try {
                DateTime parse = convertToDate(value);
                if (parse.compareTo(DateTime.now()) < 0) {
                  return "Please enter future Date";
                }
              } catch (e) {
                return 'Enter a valid date';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class ToDateTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController toDateTextEditingController;
  final TextEditingController fromDateTextEditingController;

  const ToDateTextFieldWidget({
    super.key,
    required this.labelText,
    required this.toDateTextEditingController,
    required this.fromDateTextEditingController,
  });

  @override
  State<ToDateTextFieldWidget> createState() => _ToDateTextFieldWidgetState();
}

class _ToDateTextFieldWidgetState extends State<ToDateTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.toDateTextEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  print("Date Open Called");
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 320,
                            child: DatePickerWidget(
                                widget.toDateTextEditingController));
                      });
                },
              ),
              // errorText: isValid ? "Please enter From Date." : null,
              hintText: "dd/mm/yyyy",
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
                widget.toDateTextEditingController.text = "$value/";
              }
              final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

              if (!dateRegex.hasMatch(value)) {
                return 'Enter a valid date in MM/DD/YYYY format';
              }

              try {
                DateTime parse = convertToDate(value);
                if (parse.compareTo(convertToDate(
                        widget.fromDateTextEditingController.text)) <
                    0) {
                  return "Please enter correct to Date";
                }
              } catch (e) {
                return 'Enter a valid date';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class FromTimeTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const FromTimeTextFieldWidget({
    super.key,
    required this.labelText,
    required this.textEditingController,
  });

  @override
  State<FromTimeTextFieldWidget> createState() =>
      _FromTimeTextFieldWidgetState();
}

class _FromTimeTextFieldWidgetState extends State<FromTimeTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        barrierLabel: "Select From Time");
                    if (picked != null) {
                      widget.textEditingController.text =
                          convertTimeOfDayToString(picked);
                    }
                  }),
              // errorText: isValid ? "Please enter From Date." : null,
              hintText: "10:10 AM",
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
                return 'Please enter Time';
              } else {
                if (value.length == 2) {
                  widget.textEditingController.text = "$value:";
                }
                if (value.length == 5) {
                  widget.textEditingController.text = "$value ";
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

class ToTimeTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController fromTimeTextEditingController;
  final TextEditingController toTimeTextEditingController;

  const ToTimeTextFieldWidget({
    super.key,
    required this.labelText,
    required this.fromTimeTextEditingController,
    required this.toTimeTextEditingController,
  });

  @override
  State<ToTimeTextFieldWidget> createState() => _ToTimeTextFieldWidgetState();
}

class _ToTimeTextFieldWidgetState extends State<ToTimeTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(widget.labelText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: widget.toTimeTextEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        barrierLabel: "Select From Time");
                    if (picked != null) {
                      widget.toTimeTextEditingController.text =
                          convertTimeOfDayToString(picked);
                    }
                  }),
              // errorText: isValid ? "Please enter From Date." : null,
              hintText: "10:10 AM",
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
                return 'Please enter a time';
              }

              final RegExp timeRegex =
                  RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9] (AM|PM)$');

              if (!timeRegex.hasMatch(value)) {
                return 'Enter a valid time in HH:MM AM/PM format';
              }
              try {
                TimeOfDay parse = convertToTimeOfDay(value);
                if (!isToTimeIsGreater(
                    parse,
                    convertToTimeOfDay(
                        widget.fromTimeTextEditingController.text))) {
                  return "To Time must be greater than From Time";
                }
              } catch (e) {
                return "Enter correct time";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
