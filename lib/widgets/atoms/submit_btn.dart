import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  final double height;
  final String title;
  final double borderRadius;
  final void Function() onPressed;
  const SubmitBtn(
      {super.key,
      required this.height,
      required this.title,
      required this.borderRadius,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: CustomColor.mint,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 32),
      ),
    );
  }
}
