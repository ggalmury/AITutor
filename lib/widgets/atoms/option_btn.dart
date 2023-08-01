import 'package:flutter/material.dart';

import '../../utils/custom/custom_color.dart';

class OptionBtn extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final void Function() onPressed;

  const OptionBtn(
      {super.key,
      required this.title,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(135, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
