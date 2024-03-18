import 'package:flutter/material.dart';
import 'package:yoyak/components/MainAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
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
                      Text(
                        "성현님 건강하세요",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: '오늘 드실 약은 ',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        TextSpan(
                          text: '3개',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.yellow,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        TextSpan(
                          text: '에요',
                          style: TextStyle(
                            fontSize: 22,
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
              Positioned(
                  top: 130, // 컨테이너의 위에서부터의 거리
                  child: Container(
                    width: screenWidth,
                    height: 500,
                    color: Colors.white,
                    child: Text("asdf"),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
