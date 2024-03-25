import 'package:flutter/material.dart';
import 'package:yoyak/components/card_in_rectangle.dart';
import 'package:yoyak/components/main_appbar.dart';
import 'package:yoyak/styles/colors/palette.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.BG_BLUE,
      appBar: const MainAppBar(
        color: Palette.BG_BLUE,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: '새로운 ',
                      style: TextStyle(
                        fontSize: 27,
                        color: Palette.MAIN_BLACK,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    TextSpan(
                      text: '챌린지',
                      style: TextStyle(
                        fontSize: 27,
                        color: Palette.MAIN_BLUE,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    TextSpan(
                      text: '를',
                      style: TextStyle(
                        fontSize: 27,
                        color: Palette.MAIN_BLACK,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ])),
                  const Text(
                    "시작해보세요",
                    style: TextStyle(
                      fontSize: 27,
                      color: Palette.MAIN_BLACK,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("D-5", style: TextStyle(
                          fontSize: 22,
                          color: Palette.MAIN_BLUE,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Pretendard',
                        ),),
                        RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: '현재까지 복약율  ',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Palette.MAIN_BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                              TextSpan(
                                text: '50',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Palette.MAIN_BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                              TextSpan(
                                text: '%',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Palette.MAIN_BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedProgressBar(
                        width: ScreenSize.getWidth(context) * 0.88,
                        height: 11,
                        value: 0.5,
                        duration: const Duration(seconds: 1),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.lightBlue,
                            Palette.MAIN_BLUE,
                          ],
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                  const CardInRectangle(
                    title: "성현님이 진행 중인 챌린지",
                    titleImagePath: "assets/images/medal.png",
                  ),
                  const SizedBox(height: 15,),
                  const CardInRectangle(
                    title: "챌린지 둘러보기",
                    titleImagePath: "assets/images/medal.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
