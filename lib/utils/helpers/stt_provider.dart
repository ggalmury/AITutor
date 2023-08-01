import 'dart:async';

import 'package:ai_tutor/bloc/chat_bloc.dart';
import 'package:ai_tutor/bloc/stt_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SttProvider {
  static final SttProvider _instance = SttProvider._internal();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  SttBloc? _sttBloc;
  ChatBloc? _chatBloc;

  String text = "";

  SttProvider._internal();

  factory SttProvider() {
    return _instance;
  }

  void injectBloc(SttBloc sttBloc, ChatBloc chatBloc) {
    if (_instance._sttBloc != null && _instance._chatBloc != null) return;

    _instance._sttBloc = sttBloc;
    _instance._chatBloc = chatBloc;
  }

  void startListening() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) {
        print('onStatus: $status');
      },
      onError: (error) {
        print('onError: $error');
      },
    );

    if (available) {
      _sttBloc!.add(StartListeningSttEvent());

      _speechToText.listen(
          onResult: (result) {
            text = result.recognizedWords;
          },
          localeId: 'ko_KR',
          listenFor: const Duration(minutes: 1));
    }
  }

  void stopListening() {
    _speechToText.stop();
    Timer(const Duration(seconds: 1), () {
      _sttBloc!.add(OnListeningSttEvent(newText: text));
      _chatBloc!.add(MyNewChatEvent(myChat: text));
      _chatBloc!.add(AiNewChatEvent(myChat: text));
      _sttBloc!.add(InitSttEvent());
    });
  }
}
