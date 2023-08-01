import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final Icon prefixIcon;
  final String placeholder;
  final TextEditingController controller;
  final bool? isNumber;

  const LoginInput(
      {super.key,
      required this.prefixIcon,
      required this.placeholder,
      required this.controller,
      this.isNumber});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(fontSize: 35, fontFamily: "suit_heavy"),
      keyboardType: isNumber == true ? TextInputType.number : null,
      decoration: InputDecoration(
          filled: true,
          fillColor: CustomColor.whiteGrey,
          hintText: placeholder,
          prefixIcon: prefixIcon,
          prefixIconColor: CustomColor.mint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: CustomColor.mint, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: CustomColor.mint, width: 2)),
          contentPadding: const EdgeInsets.all(15)),
    );
  }
}
