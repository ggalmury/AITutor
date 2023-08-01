import 'package:ai_tutor/apis/gpt_api.dart';
import 'package:ai_tutor/bloc/account_bloc.dart';
import 'package:ai_tutor/bloc/chat_bloc.dart';
import 'package:ai_tutor/utils/enum.dart';
import 'package:ai_tutor/widgets/components/speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stt_bloc.dart';
import '../models/external/chat.dart';
import '../utils/custom/custom_color.dart';
import '../utils/helpers/stt_provider.dart';
import '../widgets/components/other_message.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _messageBox(Chat chat) {
    Widget box;

    box = chat.chatSender == ChatSender.me
        ? SpeechBubble(chat: chat)
        : OtherMessage(chat: chat);

    return box;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      String name = context.read<AccountBloc>().state;
      context.read<GPTApi>().injectName(name);
      context.read<ChatBloc>().add(InitChatEvent());
      context
          .read<ChatBloc>()
          .add(AiNewChatEvent(myChat: "너부터 대화를 시작해보자. 내이름을 부르며 인사해줘"));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
        if (isKeyboardOpen) {
          _scrollToBottom();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("AI티쳐", style: TextStyle(fontSize: 22)),
          centerTitle: true,
          backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Expanded(
                child: BlocListener<ChatBloc, DefaultChatState>(
              listener: (context, state) {
                _scrollToBottom();
              },
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: CustomColor.whiteGrey, width: 2),
                        bottom: BorderSide(
                            color: CustomColor.whiteGrey, width: 2))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: BlocBuilder<ChatBloc, DefaultChatState>(
                    builder: (context, state) {
                      return ListView.builder(
                          controller: _scrollController,
                          itemCount: state.chatList.length,
                          itemBuilder: (context, index) {
                            return _messageBox(state.chatList[index]);
                          });
                    },
                  ),
                ),
              ),
            )),
            SizedBox(
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("마이크를 눌러서 답장하기",
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                      BlocBuilder<SttBloc, DefaultSttState>(
                          builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            state.isListening
                                ? SttProvider().stopListening()
                                : SttProvider().startListening();
                          },
                          child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: CustomColor.mint,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: const Icon(Icons.mic_rounded,
                                  color: Colors.white)),
                        );
                      })
                    ]))
          ]),
        ),
      ),
    );
  }
}
