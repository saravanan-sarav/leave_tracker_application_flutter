
import 'package:flutter/material.dart';


SnackBar customShakingSnackBarWidget({
  required Widget content,
  required Color backgroundColor,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2), // Adjust the duration as needed
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: CustomShakingSnackBar(
      content: content,
      backgroundColor: backgroundColor,
    ),
    margin: EdgeInsets.only(bottom: 710),
  );
}

class CustomShakingSnackBar extends StatefulWidget {
  final Widget content;
  final Color backgroundColor;

  CustomShakingSnackBar({required this.content, required this.backgroundColor});

  @override
  _CustomShakingSnackBarState createState() => _CustomShakingSnackBarState();
}

class _CustomShakingSnackBarState extends State<CustomShakingSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween(begin: -5.0, end: 5.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          height: 50,
          child: Transform.translate(
            offset: Offset(_animation.value, 0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(4.0),
              color: widget.backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    child: widget.content,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
