import 'package:flutter/material.dart';
import 'package:leave_tracker_application/src/domain/models/dropdownItem.dart';

class DropDownWidget extends StatefulWidget {
  final List<dynamic> listData;

  const DropDownWidget({super.key, required this.listData});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text("Request Type",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.only(top: 9,left: 10,right: 10),
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add border on all sides
              borderRadius: BorderRadius.circular(10.0)),
          child: DropdownButtonFormField<String>(
            value: _selectedItem,
            hint: const Text('Select'),
            onChanged: (newValue) {
              setState(() {
                _selectedItem = newValue!;
              });
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
            decoration: InputDecoration(
              border: InputBorder.none
            ),
          ),
        ),
      ],
    );
  }
}
