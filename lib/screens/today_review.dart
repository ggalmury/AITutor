import 'package:ai_tutor/screens/review_detail.dart';
import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:ai_tutor/widgets/atoms/submit_btn.dart';
import 'package:flutter/material.dart';

class TodayReview extends StatefulWidget {
  const TodayReview({super.key});

  @override
  State<TodayReview> createState() => _TodayReviewState();
}

class _TodayReviewState extends State<TodayReview> {
  void _onPrevBtnPressed() {
    Navigator.pop(context);
  }

  void _onMessagePracticeBtnPressed() {
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const ReviewDetail()));
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
                child: Text("오늘의 복습",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))),
        SizedBox(
            height: 130,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      children: [
                        TextSpan(text: "오늘 배운 내용을\n"),
                        TextSpan(
                            text: "복습",
                            style: TextStyle(color: CustomColor.mint)),
                        TextSpan(text: "해봅시다!"),
                      ])),
            )),
        SizedBox(height: 250, child: Image.asset("assets/images/Group.png")),
        Expanded(
            child: SizedBox(
                child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  SubmitBtn(
                    height: 70,
                    title: "메세지 앱에서 문자보내기",
                    borderRadius: 10,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    borderColor: CustomColor.mint,
                    onPressed: () {},
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset("assets/images/Stamp.png"))
                ]),
                SubmitBtn(
                  height: 70,
                  title: "전화번호 저장하기",
                  borderRadius: 10,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  borderColor: CustomColor.mint,
                  onPressed: _onMessagePracticeBtnPressed,
                ),
                const SizedBox(height: 40),
                SubmitBtn(
                  height: 70,
                  title: "이전으로 돌아가기",
                  borderRadius: 10,
                  backgroundColor: CustomColor.mint,
                  foregroundColor: Colors.white,
                  borderColor: CustomColor.mint,
                  onPressed: _onPrevBtnPressed,
                ),
              ]),
        )))
      ]),
    )));
  }
}
