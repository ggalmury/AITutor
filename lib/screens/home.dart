import 'package:ai_tutor/bloc/account_bloc.dart';
import 'package:ai_tutor/screens/ai_chat.dart';
import 'package:ai_tutor/screens/hero_meet.dart';
import 'package:ai_tutor/screens/review.dart';
import 'package:ai_tutor/screens/wallet.dart';
import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:ai_tutor/widgets/atoms/option_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/stt_bloc.dart';
import '../utils/helpers/stt_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _selectBox(String path, String text, Widget destination) {
    return GestureDetector(
        onTap: () {
          Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => destination));
        },
        child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                border: Border.all(color: const Color(0xFFF5F5F5), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Image.asset(path),
                  Text(text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)
                ]))));
  }

  void _onWalletBtnPressed() {
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const Wallet()));
  }

  void _onHeroMeetBtnPressed() {
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const HeroMeet()));
  }

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
        body: SafeArea(
            child: Column(children: [
      Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: CustomColor.whiteGrey, width: 2))),
          height: 80,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/images/person-circle.png"),
                            BlocBuilder<AccountBloc, String>(
                              builder: (context, state) {
                                return Text("$state [초급]",
                                    style: const TextStyle(fontSize: 25));
                              },
                            )
                          ]),
                    ),
                    OptionBtn(
                        title: "내 지갑",
                        backgroundColor: CustomColor.whiteMint,
                        foregroundColor: CustomColor.mint,
                        borderColor: CustomColor.whiteMint,
                        width: 135,
                        onPressed: _onWalletBtnPressed)
                  ]))),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          SizedBox(
            height: 250,
            child: Stack(children: [
              const Positioned(
                  top: 20,
                  child: Text("원하시는 메뉴를 \n선택해보세요!",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.left)),
              Positioned(
                  top: 60,
                  right: 0,
                  child: Image.asset("assets/images/Group.png")),
            ]),
          ),
          Expanded(
              child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 30, mainAxisSpacing: 30),
            children: [
              _selectBox("assets/images/main1.png", "복습하기\n", const Review()),
              _selectBox(
                  "assets/images/main2.png", "AI티쳐와\n수다떨기", const AiChat()),
              _selectBox("assets/images/main3.png", "두뇌훈련\n게임", const Review()),
              _selectBox(
                  "assets/images/main4.png", "선생님과\n상담하기", const Review())
            ],
          ))
        ]),
      )),
      GestureDetector(
        onTap: _onHeroMeetBtnPressed,
        child: Container(
            color: CustomColor.mint,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/Lim.png"),
                  const Text("영웅이 만나러 가는 길",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )),
      )
    ])));
  }
}
