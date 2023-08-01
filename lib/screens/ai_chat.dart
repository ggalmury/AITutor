import 'package:ai_tutor/bloc/chat_bloc.dart';
import 'package:ai_tutor/bloc/stt_bloc.dart';
import 'package:ai_tutor/utils/helpers/stt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SttProvider()
          .injectBloc(context.read<SttBloc>(), context.read<ChatBloc>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 600,
            child: BlocBuilder<ChatBloc, DefaultChatState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.chatList.length,
                    itemBuilder: (context, index) {
                      return Text(state.chatList[index].message);
                    });
              },
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.blue,
            child: BlocBuilder<SttBloc, DefaultSttState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    state.isListening
                        ? SttProvider().stopListening()
                        : SttProvider().startListening();
                  },
                  child: Text(state.isListening ? '중지' : '시작'),
                );
              },
            ),
          ))
        ]),
      ),
    );
  }
}
