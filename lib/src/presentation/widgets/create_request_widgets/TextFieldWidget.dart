import 'package:flutter/material.dart';

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
  bool isValid = false;

  void _inputIsValid(String value) {
    isValid = value.isEmpty;
    setState(() {});
  }

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
            onChanged: _inputIsValid,
            decoration: InputDecoration(
              errorText: isValid ? "Please enter Request Title." : null,
              labelText: widget.labelText,
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
  bool isValid = false;

  void _inputIsValid(String value) {
    isValid = value.isEmpty;
    setState(() {});
  }

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
            onChanged: _inputIsValid,
            decoration: InputDecoration(
              errorText: isValid ? "Please enter Project Name." : null,
              labelText: widget.labelText,
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
  bool isValid = false;
  FocusNode _focusNode = FocusNode();

  void _inputIsValid(String value) {
    isValid = value.isEmpty;
    setState(() {});
  }

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
            focusNode: _focusNode,
            controller: widget.textEditingController,
            onChanged: _inputIsValid,
            decoration: InputDecoration(
              errorText: isValid ? "Please Select Team ID" : null,
              labelText: widget.labelText,
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
        TextField(
          controller: widget.textEditingController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            labelText: "Reasons (Brief)",
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
          onChanged: (value) {},
        )
      ],
    );
  }
}

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
