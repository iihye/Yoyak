import 'package:flutter/material.dart';
import 'package:yoyak/components/MainAppBar.dart';
import 'package:yoyak/components/RoundedRectangle.dart';
import 'package:yoyak/hooks/goto_screen.dart';
import 'package:yoyak/screen/Alarm/alarm_create.dart';
import 'package:yoyak/screen/Alarm/alarm_screen.dart';
import 'package:yoyak/screen/Login/kakao_login_screen.dart';
import 'package:yoyak/screen/Search/filter_search_screen.dart';
import 'package:yoyak/screen/Search/photo_search_screen.dart';
import 'package:yoyak/screen/Camera/Camera.dart';
import 'package:yoyak/screen/Search/filter_search_screen.dart';
import 'package:yoyak/screen/Search/photo_search_screen.dart';
import 'package:yoyak/styles/colors/palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleSize = MediaQuery.of(context).size.width * 0.44;

    goTo(destination) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    }

    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 180,
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "성현님 건강하세요",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: '오늘 드실 약은 ',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                      TextSpan(
                        text: '3개',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.yellow,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                      TextSpan(
                        text: '에요',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ])),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueAccent,
              child: Container(
                  decoration: BoxDecoration(
                    color: Palette.BG_BLUE,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    border: Border.all(
                      width: 0.1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  width: screenWidth,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          RoundedRectangle(
                              width: rectangleSize,
                              height: rectangleSize,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PhotoSearchScreen()));
                              },
                              child: InnerRectangle(subTitle: "AI가 약을 찾아줘요", title: "사진 찍기", imagePath: "assets/images/camera.png",)
                          ),
                          const Spacer(),
                          RoundedRectangle(
                              width: rectangleSize,
                              height: rectangleSize,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FilterSearchScreen()));
                              },
                              child: InnerRectangle(subTitle: "사진 찍기 힘들다면", title: "검색하기", imagePath: "assets/images/search.png",)),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          RoundedRectangle(
                              width: rectangleSize,
                              height: rectangleSize,
                              onTap: () => goTo(CameraScreen()),
                              child: Container(
                                child: InnerRectangle(subTitle: "복용 중인 약을 한눈에", title: "MY 약 봉투", imagePath: "assets/images/envelop.png",),
                              )),
                          const Spacer(),
                          RoundedRectangle(
                              width: rectangleSize,
                              height: rectangleSize,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FilterSearchScreen()));
                              },
                              child: Container(
                                child: InnerRectangle(subTitle: "복약 시간 놓치지 마세요", title: "알림", imagePath: "assets/images/alarm.png",),
                              )),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedRectangle(
                          width: screenWidth * 0.91,
                          height: 400,
                          onTap: () => goTo(KakaoLoginScreen()),
                          child: Container(
                            child: InnerRectangle(subTitle: "꾸준히 복용해봐요", title: "챌린지 참여하기", titleImagePath: "assets/images/flag.png", hasContent: true,),
                          )),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class InnerRectangle extends StatelessWidget {
  const InnerRectangle({super.key, this.subTitle, this.title, this.imagePath, this.titleImagePath, this.hasContent});
  final subTitle, title, imagePath, titleImagePath, hasContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$subTitle", style: const TextStyle(
              fontFamily: "Pretendard",
              color: Palette.SHADOW_GREY,
              fontWeight: FontWeight.w500,
              fontSize: 15),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$title", style: const TextStyle(
                  fontFamily: "Pretendard",
                  color: Palette.MAIN_BLACK,
                  fontWeight: FontWeight.w600,
                  fontSize: 19),),
              if (titleImagePath != null)
                Image.asset(titleImagePath, height: 35,)
            ],
          ),
          if (imagePath != null) Spacer(),
          if (imagePath != null) // 이미지가 있는 경우에만 보여짐
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(imagePath, width: 75, height: 75,),
              ],
            ) else
              Container(child: Text("asdf"),)
          ]
      ),
    );
  }
}
