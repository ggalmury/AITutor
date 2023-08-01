import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../utils/custom/custom_color.dart';
import '../widgets/atoms/submit_btn.dart';

class ReviewDetail extends StatefulWidget {
  const ReviewDetail({super.key});

  @override
  State<ReviewDetail> createState() => _ReviewDetailState();
}

class _ReviewDetailState extends State<ReviewDetail> {
  late VideoPlayerController _videoPlayerController;
  bool _isVideoInitialized = false;

  void _onPrevBtnPressed() {
    Navigator.pop(context);
  }

  void _endReviewPressed() {
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
                        const Text("복습을 완료했습니다!",
                            style: TextStyle(fontSize: 22)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/gold.png"),
                              const Text("+100포인트",
                                  style: TextStyle(
                                      color: CustomColor.mint,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ]),
                        const Text("포인트는 3일 이내에\n적립됩니다",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22))
                      ]),
                      SubmitBtn(
                          height: 56,
                          title: "닫기",
                          borderRadius: 30,
                          backgroundColor: CustomColor.mint,
                          foregroundColor: Colors.white,
                          borderColor: CustomColor.mint,
                          onPressed: () {})
                    ],
                  ),
                )),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/images/test_video.mp4')
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
          });
    _videoPlayerController.play(); // 비디오를 자동으로 재생하려면 주석을 해제하세요.
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        const SizedBox(
            height: 80,
            child: Center(
                child: Text("전화번호 저장하기",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))),
        Expanded(
          child: _isVideoInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        SizedBox(
            height: 150,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      children: [
                        TextSpan(text: "영상을 끝까지 시청하시면\n"),
                        TextSpan(
                            text: "칭찬도장",
                            style: TextStyle(color: CustomColor.mint)),
                        TextSpan(text: "을 드립니다!"),
                      ])),
            )),
        SizedBox(
            height: 250,
            child: GestureDetector(
                onTap: _endReviewPressed,
                child: Image.asset("assets/images/Group.png"))),
        SubmitBtn(
          height: 70,
          title: "이전으로 돌아가기",
          borderRadius: 10,
          backgroundColor: CustomColor.mint,
          foregroundColor: Colors.white,
          borderColor: CustomColor.mint,
          onPressed: _onPrevBtnPressed,
        ),
        const SizedBox(height: 40)
      ]),
    )));
  }
}
