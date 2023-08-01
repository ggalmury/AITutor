import 'package:ai_tutor/screens/review_list.dart';
import 'package:ai_tutor/screens/today_review.dart';
import 'package:ai_tutor/utils/custom/custom_color.dart';
import 'package:ai_tutor/widgets/atoms/submit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cash_stack_bloc.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  void _onPrevBtnPressed() {
    Navigator.pop(context);
  }

  void _onTodayReviewPressed() {
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const TodayReview()));
  }

  void _onReviewListPressed() {
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const ReviewList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        SizedBox(
            height: 160,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      children: [
                        TextSpan(
                            text: "복습",
                            style: TextStyle(color: CustomColor.mint)),
                        TextSpan(text: "을 통해\n"),
                        TextSpan(
                            text: "포인트",
                            style: TextStyle(color: CustomColor.mint)),
                        TextSpan(text: "를 모아볼까요?"),
                      ])),
            )),
        SizedBox(
            height: 300,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset("assets/images/gold.png"),
                    BlocBuilder<CashStackBloc, int>(
                      builder: (context, state) {
                        return Text((state * 100).toString(),
                            style: const TextStyle(fontSize: 22));
                      },
                    )
                  ]),
                  Image.asset("assets/images/Group.png")
                ])),
        Expanded(
            child: SizedBox(
                child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubmitBtn(
                  height: 70,
                  title: "오늘의 복습",
                  borderRadius: 10,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  borderColor: CustomColor.mint,
                  onPressed: _onTodayReviewPressed,
                ),
                SubmitBtn(
                  height: 70,
                  title: "전체보기",
                  borderRadius: 10,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  borderColor: CustomColor.mint,
                  onPressed: _onReviewListPressed,
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
