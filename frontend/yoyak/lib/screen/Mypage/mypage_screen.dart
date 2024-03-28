import 'package:flutter/material.dart';
import 'package:yoyak/screen/Mypage/privacy_policy.dart';
import 'package:yoyak/styles/colors/palette.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.MAIN_BLUE,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/logo.png"),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MypageScreen(),
                    ));
              },
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("assets/images/person-image.png")),
            ),
          ],
        ),
      ),
    );
  }
}
