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
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dialog 닫기
                      },
                    ),
                  ),
                  Positioned(
                      top: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<CashStackBloc, int>(
                            builder: (context, state) {
                              return Text("칭찬도장 갯수 : $state/14");
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
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
            OptionBtn(
                title: "NFT수료증",
                backgroundColor: CustomColor.whiteMint,
                foregroundColor: CustomColor.mint,
                borderColor: CustomColor.whiteMint,
                width: 160,
                onPressed: _lessStampDialog)
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
