import 'package:ai_tutor/apis/gpt_api.dart';
import 'package:ai_tutor/models/external/chat.dart';
import 'package:ai_tutor/utils/enum.dart';
import 'package:ai_tutor/utils/helpers/tts_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ChatBloc extends Bloc<DefaultChatEvent, DefaultChatState> {
  final GPTApi _gptApi;

  ChatBloc(this._gptApi) : super(InitChatState()) {
    on<DefaultChatEvent>((event, emit) async {
      if (event is AiNewChatEvent) {
        await _aiNewChatEventHandler(event, emit);
      } else if (event is MyNewChatEvent) {
        _myNewChatEventHandler(event, emit);
      } else if (event is InitChatEvent) {
        _initChatEventHandler(event, emit);
      }
    });
  }

  _aiNewChatEventHandler(AiNewChatEvent event, emit) async {
    String? gptResponse = await _gptApi.fetchAnswer(event.myChat);

    if (gptResponse != null) {
      Chat newChat = Chat(chatSender: ChatSender.ai, message: gptResponse);

      List<Chat> newChatList = List.from(state.chatList);
      newChatList.add(newChat);

      // GPT 답변 TTS로 출력
      TtsProvider().speak(newChat.message);

      emit(CurrentChatState(chatList: newChatList));
    }
  }

  _myNewChatEventHandler(MyNewChatEvent event, emit) {
    Chat newChat = Chat(chatSender: ChatSender.me, message: event.myChat);

    List<Chat> newChatList = List.from(state.chatList);
    newChatList.add(newChat);

    emit(CurrentChatState(chatList: newChatList));
  }

  _initChatEventHandler(InitChatEvent event, emit) {
    emit(const CurrentChatState(chatList: []));
  }
}

// event
abstract class DefaultChatEvent extends Equatable {}

class InitChatEvent extends DefaultChatEvent {
  InitChatEvent();

  @override
  List<Object> get props => [];
}

class AiNewChatEvent extends DefaultChatEvent {
  final String myChat;

  AiNewChatEvent({required this.myChat});

  @override
  List<Object> get props => [myChat];
}

class MyNewChatEvent extends DefaultChatEvent {
  final String myChat;

  MyNewChatEvent({required this.myChat});

  @override
  List<Object> get props => [myChat];
}

class FirstChatEvent extends DefaultChatEvent {
  final String myChat;

  FirstChatEvent({required this.myChat});

  @override
  List<Object> get props => [myChat];
}

// state
abstract class DefaultChatState extends Equatable {
  final List<Chat> chatList;

  const DefaultChatState({required this.chatList});
}

class InitChatState extends DefaultChatState {
  InitChatState() : super(chatList: []);

  @override
  List<Object> get props => [chatList];
}

class CurrentChatState extends DefaultChatState {
  const CurrentChatState({required super.chatList});

  @override
  List<Object> get props => [chatList];
}
