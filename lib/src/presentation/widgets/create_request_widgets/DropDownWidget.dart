import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_tracker_application/src/presentation/state_management/FromTimeToTimeState.dart';
import 'package:leave_tracker_application/src/presentation/state_management/requestTypeState.dart';

class DropDownWidget extends ConsumerStatefulWidget {
  const DropDownWidget({super.key});

  @override
  ConsumerState<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends ConsumerState<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    var requestTypes = ref.watch(requestTypeProvider);
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
        Container(
          padding: EdgeInsets.only(top: 9, left: 10, right: 10),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              // Add border on all sides
              borderRadius: BorderRadius.circular(10.0)),
          child: DropdownButtonFormField<String>(
            hint: const Text('Select'),
            onChanged: (newValue) {
              if (newValue == "Permission") {
                ref.read(permissionNotifyProvider.notifier).updateState();
              } else {
                ref.read(permissionNotifyProvider.notifier).setState();
              }
            },
            items:
                requestTypes.map<DropdownMenuItem<String>>((RequestType item) {
              return DropdownMenuItem<String>(
                value: item.type,
                child: Text(item.type),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select Request Type';
              }
              return null;
            },
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
