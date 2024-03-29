import 'package:flutter/material.dart';
import 'package:yoyak/styles/colors/palette.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.MAIN_WHITE,
        elevation: 0,
        title: const Text(
          "마이페이지",
          style: TextStyle(
            color: Palette.MAIN_BLACK,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
