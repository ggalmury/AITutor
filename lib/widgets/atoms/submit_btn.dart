import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  final double height;
  final String title;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final void Function() onPressed;

  const SubmitBtn(
      {super.key,
      required this.height,
      required this.title,
      required this.borderRadius,
      required this.onPressed,
      required this.borderColor,
      required this.backgroundColor,
      required this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, height),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor),
      child: Text(
        title,
        style: TextStyle(fontSize: 25, color: foregroundColor),
      ),
    );
  }
}
