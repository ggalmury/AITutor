import 'package:flutter_tts/flutter_tts.dart';

// TTS 관련 로직
class TtsProvider {
  static final TtsProvider _instance = TtsProvider._internal();
  final FlutterTts tts = FlutterTts();

  TtsProvider._internal();

  factory TtsProvider() {
    return _instance;
  }

  // tts setting
  void setLanguage(String language) async {
    await tts.setLanguage(language);
  }

  void setSpeachRate(double rate) async {
    await tts.setSpeechRate(rate);
  }

  // tts functions
  void speak(String text) async {
    await tts.speak(text);
  }
}
