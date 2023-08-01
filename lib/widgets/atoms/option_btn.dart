import 'package:flutter/material.dart';

class OptionBtn extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double width;
  final Icon? icon;
  final void Function() onPressed;

  const OptionBtn({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.width,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 2, color: borderColor),
        minimumSize: Size(width, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Row(
        children: [
          if (icon != null)
            Row(children: [Icon(icon!.icon), const SizedBox(width: 10)]),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
