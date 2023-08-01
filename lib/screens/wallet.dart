import 'package:ai_tutor/bloc/account_bloc.dart';
import 'package:ai_tutor/bloc/cash_stack_bloc.dart';
import 'package:ai_tutor/widgets/atoms/option_btn.dart';
import 'package:ai_tutor/widgets/atoms/submit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/custom/custom_color.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  void _onPrevBtnPressed() {
    Navigator.pop(context);
  }

  void _lessStampDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
                width: 320,
                height: 320,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      BlocBuilder<CashStackBloc, int>(
                        builder: (context, state) {
                          return RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  children: [
                                const TextSpan(text: "칭찬도장 갯수 : "),
                                TextSpan(
                                    text: state.toString(),
                                    style: const TextStyle(
                                        color: CustomColor.mint)),
                                const TextSpan(text: "/14")
                              ]));
                        },
                      ),
                      const SizedBox(height: 30),
                      Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  children: [
                                    TextSpan(text: "모든 칭찬 도장을 모으시면\n"),
                                    TextSpan(
                                        text: "영웅이 기념품",
                                        style:
                                            TextStyle(color: CustomColor.mint)),
                                    TextSpan(text: "을 받을 수 있는\n"),
                                    TextSpan(
                                        text: "수료증",
                                        style:
                                            TextStyle(color: CustomColor.mint)),
                                    TextSpan(text: "을 발급해 드립니다!"),
                                  ]))),
                      const SizedBox(height: 30),
                      SubmitBtn(
                          height: 56,
                          title: "복습하러 가기",
                          borderRadius: 30,
                          onPressed: () {})
                    ],
                  ),
                )),
          );
        });
  }

  void _enoughStampDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
                width: 320,
                height: 500,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      BlocBuilder<AccountBloc, String>(
                          builder: (context, state) {
                        return RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                                children: [
                              TextSpan(
                                  text: state,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(text: "님의 "),
                              const TextSpan(
                                  text: "NTF수료증",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]));
                      }),
                      Image.asset("assets/images/nft.png"),
                      SubmitBtn(
                          height: 55,
                          title: "저장하기",
                          borderRadius: 30,
                          onPressed: () {}),
                      SubmitBtn(
                          height: 55,
                          title: "공유하기",
                          borderRadius: 30,
                          isWhite: true,
                          onPressed: () {})
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
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: CustomColor.whiteGrey, width: 2))),
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("내 지갑",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Row(children: [
                    Image.asset("assets/images/gold.png"),
                    BlocBuilder<CashStackBloc, int>(
                      builder: (context, state) {
                        return Text((state * 100).toString(),
                            style: const TextStyle(fontSize: 22));
                      },
                    )
                  ])
                ])),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OptionBtn(
                title: "QR코드",
                backgroundColor: Colors.white,
                foregroundColor: CustomColor.mint,
                borderColor: CustomColor.mint,
                width: 160,
                icon: const Icon(Icons.qr_code),
                onPressed: () {}),
            BlocBuilder<CashStackBloc, int>(builder: (context, state) {
              return OptionBtn(
                  title: "NFT수료증",
                  backgroundColor: CustomColor.whiteMint,
                  foregroundColor: CustomColor.mint,
                  borderColor: CustomColor.whiteMint,
                  width: 160,
                  onPressed:
                      state == 14 ? _enoughStampDialog : _lessStampDialog);
            })
          ],
        ),
        const SizedBox(height: 10),
        Expanded(child: BlocBuilder<CashStackBloc, int>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: state,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: CustomColor.whiteGrey, width: 2))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("오늘의 복습", style: TextStyle(fontSize: 22)),
                            Text("+100P",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: CustomColor.mint,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                  );
                });
          },
        )),
        SizedBox(
            height: 120,
            child: Center(
                child: SubmitBtn(
                    height: 70,
                    title: "이전으로 돌아가기",
                    borderRadius: 10,
                    onPressed: _onPrevBtnPressed)))
      ]),
    )));
  }
}
