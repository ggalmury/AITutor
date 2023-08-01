import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:ai_tutor/widgets/atoms/option_btn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String name;

  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                      width: 175,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/images/person-circle.png"),
                            Text("${widget.name}[초급]",
                                style: const TextStyle(fontSize: 25))
                          ]),
                    ),
                    OptionBtn(
                        title: "내 지갑",
                        backgroundColor: CustomColor.whiteMint,
                        foregroundColor: CustomColor.mint,
                        onPressed: () {})
                  ]))),
      Expanded(
          child: Column(children: [
        Container(color: Colors.red, height: 250),
        Expanded(child: Container(color: Colors.green))
      ])),
      Container(
          color: CustomColor.mint,
          height: 90,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
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
          ))
    ])));
  }
}
