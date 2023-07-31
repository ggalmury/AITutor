import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SttTest extends StatefulWidget {
  const SttTest({super.key});

  @override
  State<SttTest> createState() => _SttTestState();
}

class _SttTestState extends State<SttTest> {
  late stt.SpeechToText _speechToText;
  String _text = '음성을 입력하세요.';
  bool _isListening = false;

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          print('onStatus: $status');
        },
        onError: (error) {
          print('onError: $error');
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
          _text = '말씀하세요...';
        });

        _speechToText.listen(
            onResult: (result) {
              setState(() {
                _text = result.recognizedWords;
              });
            },
            localeId: 'ko_KR');
      }
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음성 입력'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_text),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              child: Text(_isListening ? '중지' : '시작'),
            ),
          ],
        ),
      ),
    );
  }
}
