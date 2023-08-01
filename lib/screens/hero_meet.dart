import 'package:ai_tutor/bloc/cash_stack_bloc.dart';
import 'package:ai_tutor/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/custom/custom_color.dart';
import '../widgets/atoms/submit_btn.dart';

class HeroMeet extends StatefulWidget {
  const HeroMeet({super.key});

  @override
  State<HeroMeet> createState() => _HeroMeetState();
}

class _HeroMeetState extends State<HeroMeet> {
  void _onGoToWalletBtnPressed() {
    context.read<CashStackBloc>().add(IncreaseCashStackEvent());

    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const Wallet()));
  }

  void _onLimPressed() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
                width: 320,
                height: 450,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dialog 닫기
                          },
                        ),
                      ),
                      Column(children: [
                        Image.asset("assets/images/Lim.png"),
                        const Text("축하드립니다!\n드디어 영웅이를 만나셨군요!",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 20),
                        RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "영웅이 기념품",
                                      style:
                                          TextStyle(color: CustomColor.mint)),
                                  TextSpan(text: "을\n"),
                                  TextSpan(text: "수령할 수 있는"),
                                  TextSpan(
                                      text: "수료증",
                                      style:
                                          TextStyle(color: CustomColor.mint)),
                                  TextSpan(text: "을\n"),
                                  TextSpan(text: "발급해 드릴게요!")
                                ]))
                      ]),
                      SubmitBtn(
                          height: 56,
                          title: "수료증 발급받기",
                          borderRadius: 30,
                          backgroundColor: CustomColor.mint,
                          foregroundColor: Colors.white,
                          borderColor: CustomColor.mint,
                          onPressed: _onGoToWalletBtnPressed)
                    ],
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const SizedBox(
          height: 80,
          child: Center(
              child: Text("영웅이 만나러 가는 길",
                  style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))),
      Expanded(
          child: Stack(children: [
        Image.asset("assets/images/goToHero.png"),
        Positioned(
            top: 13,
            left: 8,
            child: GestureDetector(
                onTap: _onLimPressed,
                child: Image.asset("assets/images/Lim.png")))
      ])),
    ])));
  }
}
