import 'package:flutter/material.dart';

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget({super.key});

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: _isPressed ? Colors.blue.withOpacity(0.5) : Colors.blue,
          ),
          child: const Text(
            'Tap Me!',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
