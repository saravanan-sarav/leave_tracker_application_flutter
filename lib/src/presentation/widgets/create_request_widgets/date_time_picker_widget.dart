import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/utils/constants/date_parser.dart';

class FromDatePickerWidget extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;

  const FromDatePickerWidget(this.textEditingController, {super.key});

  @override
  ConsumerState<FromDatePickerWidget> createState() =>
      _FromDatePickerWidgetState();
}

class _FromDatePickerWidgetState extends ConsumerState<FromDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomPicker.date(
          pickerTitle: const Text(
            'Select From Date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: widget.textEditingController.text.isEmpty
              ? DateTime.now()
              : convertToDate(widget.textEditingController.text),
          maxDateTime: DateTime(DateTime.now().year + 10),
          minDateTime: DateTime(DateTime.now().year - 10),
          pickerTextStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
  final TextEditingController textEditingController;

  const ToDatePickerWidget(this.textEditingController, {super.key});

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
          pickerTitle: const Text(
            'Select To Date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: widget.textEditingController.text.isEmpty
              ? DateTime.now()
              : convertToDate(widget.textEditingController.text),
          maxDateTime: DateTime(DateTime.now().year + 10),
          minDateTime: DateTime(DateTime.now().year - 10),
          pickerTextStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bottomPickerTheme: BottomPickerTheme.heavyRain,
          onSubmit: (index) {
            widget.textEditingController.text = formatDateAsNumber(index);
          },
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
