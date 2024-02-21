import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/domain/models/dropdownItem.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedItem,
          hint: Text('Select an item'),
          onChanged: (newValue) {
            setState(() {
              _selectedItem = newValue!;
            });
          },
          items: requestTypes.map<DropdownMenuItem<String>>((RequestType item) {
            return DropdownMenuItem<String>(
              value: item.type,
              child: Text(item.type),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          'Selected item: ${_selectedItem ?? 'None'}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
