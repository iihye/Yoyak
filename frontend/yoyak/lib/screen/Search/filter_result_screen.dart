import 'package:flutter/material.dart';
import '../../styles/colors/palette.dart';
import 'package:yoyak/components/rounded_rectangle.dart';

class FilterResult extends StatelessWidget {
  const FilterResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '알약 검색',
          style: TextStyle(
            color: Palette.MAIN_BLACK,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        backgroundColor: Palette.BG_BLUE,
        centerTitle: true,
        toolbarHeight: 55,
      ),
      body: Container(
        width: double.infinity,
        color: Palette.BG_BLUE,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "필터로 알약 검색",
                  style: TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
