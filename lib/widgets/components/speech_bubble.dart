import 'package:ai_tutor/models/external/chat.dart';
import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:ai_tutor/utils/enum.dart';
import 'package:flutter/material.dart';

class SpeechBubble extends StatelessWidget {
  final Chat chat;

  const SpeechBubble({super.key, required this.chat});

  List<Widget> _widgets() {
    return [
      const SizedBox(width: 10),
      Container(
          constraints: const BoxConstraints(
            maxWidth: 290,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      chat.chatSender == ChatSender.me ? 15 : 0),
                  topRight: const Radius.circular(15),
                  bottomLeft: const Radius.circular(15),
                  bottomRight: Radius.circular(
                      chat.chatSender == ChatSender.me ? 0 : 15)),
              color: chat.chatSender == ChatSender.me
                  ? CustomColor.mint
                  : CustomColor.aiChat),
          padding: const EdgeInsets.all(12),
          child: Text(chat.message,
              style: TextStyle(
                  fontSize: 20,
                  color: chat.chatSender == ChatSender.me
                      ? Colors.white
                      : Colors.black)))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: chat.chatSender == ChatSender.me
                ? _widgets()
                : _widgets().reversed.toList()));
  }
}
