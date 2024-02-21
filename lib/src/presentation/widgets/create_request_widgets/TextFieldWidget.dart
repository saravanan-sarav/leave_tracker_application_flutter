import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;

  const TextFieldWidget({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(labelText,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey),
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
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }
}
