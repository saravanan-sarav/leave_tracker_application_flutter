import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/utils/constants/date_parser.dart';

class DatePickerWidget extends ConsumerStatefulWidget {
  TextEditingController textEditingController;

  DatePickerWidget(this.textEditingController, {super.key});

  @override
  ConsumerState<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends ConsumerState<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomPicker.date(
          title: 'Select From Date',
          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: DateTime.now(),
          maxDateTime: DateTime(2030),
          minDateTime: DateTime(2023),
          pickerTextStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          titleStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.blue,
          ),
          onSubmit: (index) {
            widget.textEditingController.text = formatDateAsNumber(index);
          },
          bottomPickerTheme: BottomPickerTheme.heavyRain,
          buttonStyle: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.cyan[200]!,
            ),
          ),
          buttonWidth: 150,
          buttonContent: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ToDatePickerWidget extends ConsumerStatefulWidget {
  const ToDatePickerWidget({super.key});

  @override
  ConsumerState<ToDatePickerWidget> createState() => _ToDatePickerWidgetState();
}

class _ToDatePickerWidgetState extends ConsumerState<ToDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomPicker.date(
          title: 'Select To Date',
          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: DateTime.now(),
          maxDateTime: DateTime(2030),
          minDateTime: DateTime(2023),
          pickerTextStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          titleStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.blue,
          ),
          onSubmit: (index) async {
            final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                barrierLabel: "Select From Time");
          },
          bottomPickerTheme: BottomPickerTheme.heavyRain,
          buttonStyle: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.cyan[200]!,
            ),
          ),
          buttonWidth: 150,
          buttonContent: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
