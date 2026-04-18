import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/others_notifier.dart';
import 'package:leave_tracker_application/src/presentation/state_management/permission_notifier.dart';

import '../../../domain/models/request_type.dart';
import '../../providers/request_providers/request_type_provider.dart';

class DropDownWidget extends ConsumerStatefulWidget {
  final TextEditingController textEditingController;

  const DropDownWidget(this.textEditingController, {super.key});

  @override
  ConsumerState<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends ConsumerState<DropDownWidget> {
  bool permissionEnabled = false;
  bool othersEnabled = false;

  @override
  void initState() {
    if (ref.read(permissionNotifyProvider.notifier).getState()) {
      permissionEnabled = true;
      widget.textEditingController.text = "5";
    }
    if (ref.read(othersNotifyProvider.notifier).getState()) {
      othersEnabled = true;
      widget.textEditingController.text = "7";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var requestTypes =
        ref.read(requestTypesProvider.notifier).getRequestTypes();
    int? value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Request Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButtonFormField<int>(
          // enableFeedback: false,
          hint: const Text('Request Type'),
          initialValue: permissionEnabled
              ? 5
              : othersEnabled
                  ? 7
                  : value,
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
          onChanged: (newValue) {
            value = newValue!;
            print(value);
            if (newValue == 5) {
              ref.read(permissionNotifyProvider.notifier).updateState();
            } else {
              ref.read(permissionNotifyProvider.notifier).setState();
            }
            if (newValue == 7) {
              ref.read(othersNotifyProvider.notifier).updateState();
            } else {
              ref.read(othersNotifyProvider.notifier).setState();
            }
            widget.textEditingController.text = "$newValue";
          },
          items: requestTypes.map<DropdownMenuItem<int>>((RequestType item) {
            return DropdownMenuItem<int>(
              value: item.id,
              child: Text(item.type),
            );
          }).toList(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return 'Please select Request Type';
            }
            return null;
          },
        ),
      ],
    );
  }
}
