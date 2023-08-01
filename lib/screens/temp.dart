import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Teacher for Seniors'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('A.I Teacher'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TutorScreen()),
            );
          },
        ),
      ),
    );
  }
}

class TutorScreen extends StatefulWidget {
  @override
  _TutorScreenState createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  FlutterTts? _tts;
  String _status = 'Ready to listen';
  String? _error;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speak to Tutor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: _listen,
            ),
            Text(_status),
            if (_error != null)
              Text(
                'Error: $_error',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => setState(() => _status = 'STT status: $val'),
        onError: (val) => setState(() => _error = 'STT error: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          _status = 'Listening...';
          _error = null;
        });
        _speech!.listen(
          onResult: (val) => print('onResult: ${val.recognizedWords}'),
          localeId: 'ko-KR', // Use Korean for the STT service
        );
      } else {
        setState(() => _error = 'STT service not available');
      }
    } else {
      setState(() {
        _isListening = false;
        _status = 'Processing...';
      });
      _speech!.stop();

      String text = _speech!.lastRecognizedWords;
      try {
        var response = await http.post(
          Uri.parse(
              'https://api.openai.com/v1/engines/text-davinci-003/completions'), // OpenAI's GPT-3 API URL
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'Bearer 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', // Replace with your actual OpenAI API key
          },
          body: jsonEncode(<String, dynamic>{
            'prompt': text,
            'max_tokens': 60,
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> result = jsonDecode(response.body);
          String gptResponse =
              result['choices'][0]['text']; // OpenAI's GPT-3 response key

          // Remove newline characters

          if (await _tts!.isLanguageAvailable('ko-KR')) {
            // Use Korean for the TTS service
            await _tts!.setLanguage('ko-KR');

            await _tts!.speak(gptResponse);
            setState(() => _status = 'Ready to listen');
          } else {
            setState(() => _error = 'TTS service not available');
          }
        } else {
          setState(() => _error = 'Failed to load GPT response');
        }
      } catch (e) {
        setState(() => _error = 'Failed to send request to GPT model API');
      }
    }
  }
}
