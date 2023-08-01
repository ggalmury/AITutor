import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:ai_tutor/utils/helpers/constants.dart';
import 'package:ai_tutor/widgets/atoms/submit_btn.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  void _onPrevBtnPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: CustomColor.whiteGrey, width: 2))),
            height: 80,
            child: const Center(
                child: Text("전체보기",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))),
        Expanded(
          child: ListView.builder(
            itemCount: 14,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SubmitBtn(
                      height: 70,
                      title: reviewList[index],
                      borderRadius: 10,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      borderColor: CustomColor.mint,
                      onPressed: () {}),
                  const SizedBox(height: 25)
                ],
              );
            },
          ),
        ),
        SizedBox(
            height: 100,
            child: Center(
                child: SubmitBtn(
              height: 70,
              title: "이전으로 돌아가기",
              borderRadius: 10,
              backgroundColor: CustomColor.mint,
              foregroundColor: Colors.white,
              borderColor: CustomColor.mint,
              onPressed: _onPrevBtnPressed,
            )))
      ]),
    )));
  }
}
