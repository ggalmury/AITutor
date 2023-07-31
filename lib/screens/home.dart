import 'package:ai_tutor/utils/helpers/tts_provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
            child: Column(
          children: [
            TextField(controller: _textEditingController),
            ElevatedButton(
                onPressed: () {
                  TtsProvider().speak(_textEditingController.text);
                },
                child: const Text("button"))
          ],
        )),
      ),
    );
  }
}
