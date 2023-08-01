import 'package:ai_tutor/widgets/components/speech_bubble.dart';
import 'package:flutter/material.dart';

import '../../models/external/chat.dart';

class OtherMessage extends StatelessWidget {
  final Chat chat;

  const OtherMessage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset("assets/images/aiPic.png"),
      ),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("AI티쳐", style: TextStyle(fontWeight: FontWeight.bold)),
        SpeechBubble(
          chat: chat,
        )
      ])
    ]);
  }
}
