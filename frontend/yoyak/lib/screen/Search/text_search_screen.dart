import 'package:flutter/material.dart';
import '../../styles/colors/palette.dart';

class TextSearchScreen extends StatefulWidget {
  const TextSearchScreen({super.key});

  @override
  State<TextSearchScreen> createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알약 검색',
            style: TextStyle(
              color: Palette.MAIN_BLACK,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 15,
            )),
        backgroundColor: Palette.BG_BLUE,
        centerTitle: true,
        toolbarHeight: 55,
      ),
      body: Container(
        width: double.infinity,
        color: Palette.BG_BLUE,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
          vertical: MediaQuery.of(context).size.height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                "알약 검색",
                style: TextStyle(
                    color: Palette.MAIN_BLACK,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: SearchBar(
              //   leading: const Icon(
              //     Icons.search,
              //     color: Palette.MAIN_BLUE,
              //     size: 25,
              //   ),
              //   backgroundColor:
              //       const MaterialStatePropertyAll(Palette.MAIN_WHITE), // 흠..
              //   hintText: '알약 이름, 증상을 입력해주세요', // padding...
              //   hintStyle: MaterialStateProperty.all(
              //     const TextStyle(
              //       color: Palette.SUB_BLACK,
              //       fontFamily: 'Pretendard',
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //       height: BorderSide.strokeAlignCenter,
              //     ),
              //   ),

              //   shape: MaterialStateProperty.all(
              //     RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              //   shadowColor: MaterialStateColor.resolveWith(
              //       (states) => Palette.SHADOW_GREY),
              //   constraints: BoxConstraints(
              //     maxHeight: MediaQuery.of(context).size.width * 0.1,
              //     maxWidth: double.infinity,
              //   ),
              //   padding: const MaterialStatePropertyAll(
              //     EdgeInsets.symmetric(
              //       horizontal: 10,
              //       vertical: 5,
              //     ),
              //   ),
              //   // 검색어 제출을 했을 때 실행되는 함수
              //   onSubmitted: (value) {
              //     print('검색어 = $value');
              //   },
              // ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.1,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.SHADOW_GREY,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  cursorColor: Palette.MAIN_BLUE,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 11,
                    ),
                    border: InputBorder.none,
                    hintText: '알약 이름, 증상을 입력해주세요',
                    filled: true,
                    fillColor: Palette.MAIN_WHITE,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(
                      color: Palette.SUB_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Palette.MAIN_BLUE,
                      size: 25,
                    ),
                  ),
                  onSubmitted: (value) {
                    print('검색어 = $value');
                  },
                  // 검색 결과 api 요청 -> 결과 화면으로 이동
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
