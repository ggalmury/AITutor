import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  final double height;
  final String title;
  final double borderRadius;
  final void Function() onPressed;
  final bool? isWhite;

  const SubmitBtn(
      {super.key,
      required this.height,
      required this.title,
      required this.borderRadius,
      required this.onPressed,
      this.isWhite});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 2,
              color: isWhite == true ? CustomColor.mint : Colors.white),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: isWhite == true ? Colors.white : CustomColor.mint,
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 28,
            color: isWhite == true ? CustomColor.mint : Colors.white),
      ),
    );
  }
}
