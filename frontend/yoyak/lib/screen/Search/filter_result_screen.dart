import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yoyak/components/pill_preview.dart';
import '../../styles/colors/palette.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:lottie/lottie.dart';

final Map<String, dynamic> dummyPillData = {
  "count": 2,
  "result": [
    {
      "medicineSeq": 195900043,
      "imgPath": null,
      "itemName": "아네모정",
      "entpName": "삼진제약(주)"
    },
    {
      "medicineSeq": 202001409,
      "imgPath": "https://www.druginfo.co.kr/drugimg/251234.jpg",
      "itemName": "아네린정",
      "entpName": "일양약품(주)"
    }
  ]
};

class FilterResult extends StatelessWidget {
  final Map<String, dynamic> data;

  const FilterResult({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 검색 결과가 없을 때, 있을 때 분기
    bool isResult = data["result"] != null && data["result"].length > 0;
    print(isResult);

    // PillPreview 위젯 생성
    // return Scaffold(
    //   backgroundColor: Palette.BG_BLUE,
    //   appBar: AppBar(
    //     title: const Text(
    //       '알약 검색',
    //       style: TextStyle(
    //         color: Palette.MAIN_BLACK,
    //         fontFamily: 'Pretendard',
    //         fontWeight: FontWeight.w400,
    //         fontSize: 15,
    //       ),
    //     ),
    //     backgroundColor: Palette.BG_BLUE,
    //     centerTitle: true,
    //     toolbarHeight: 55,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Container(
    //       width: double.infinity,
    //       // color: Palette.BG_BLUE,
    //       padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           // crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Container(
    //                   padding: const EdgeInsets.only(left: 10),
    //                   child: const Text(
    //                     "필터로 알약 검색",
    //                     style: TextStyle(
    //                         color: Palette.MAIN_BLACK,
    //                         fontFamily: 'Pretendard',
    //                         fontWeight: FontWeight.w700,
    //                         fontSize: 24),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   width: 10,
    //                 ),
    //                 Image.asset(
    //                   'assets/images/pill.png',
    //                   width: 30,
    //                   height: 30,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             Container(
    //               padding: const EdgeInsets.only(left: 10),
    //               alignment: Alignment.centerLeft,
    //               child: const Text(
    //                 "검색 결과",
    //                 style: TextStyle(
    //                     color: Palette.MAIN_BLACK,
    //                     fontFamily: 'Pretendard',
    //                     fontWeight: FontWeight.w700,
    //                     fontSize: 24),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             Column(
    //               children: isResult
    //                   ? data["result"].map<Widget>((pill) {
    //                       var imgPath = pill["imgPath"];
    //                       var itemName = pill["itemName"];
    //                       var entpName = pill["entpName"];
    //                       var medicineSeq = pill["medicineSeq"];
    //                       return PillPreview(
    //                           imgPath: imgPath,
    //                           itemName: itemName,
    //                           entpName: entpName,
    //                           medicineSeq: medicineSeq);
    //                     }).toList()
    //                   // PillPreviews 출력
    //                   : [
    //                       // 로티
    //                       Lottie.asset(
    //                         'assets/lotties/no_search.json',
    //                         alignment: Alignment.center,
    //                         width: MediaQuery.of(context).size.width * 0.750,
    //                         height: MediaQuery.of(context).size.height * 0.40,
    //                         // fit: BoxFit.fill,
    //                       ),
    //                       const Text(
    //                         "검색 결과가 없습니다.",
    //                         style: TextStyle(
    //                           color: Palette.SUB_BLACK,
    //                           fontFamily: 'Pretendard',
    //                           fontWeight: FontWeight.w400,
    //                           fontSize: 20,
    //                         ),
    //                       ),
    //                     ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    List<Widget> pillPreviews =
        List.from(dummyPillData["result"]).map<Widget>((pill) {
      var imgPath = pill["imgPath"];
      var itemName = pill["itemName"];
      var entpName = pill["entpName"];
      var medicineSeq = pill["medicineSeq"];
      return PillPreview(
          imgPath: imgPath,
          itemName: itemName,
          entpName: entpName,
          medicineSeq: medicineSeq);
    }).toList(); // map의 결과를 List<Widget>으로 변환

    return Scaffold(
      backgroundColor: Palette.BG_BLUE,
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // color: Palette.BG_BLUE,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/pill.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "검색 결과",
                    style: TextStyle(
                        color: Palette.MAIN_BLACK,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // 알약 미리보기
                // API 연결하면 refactoring

                ...pillPreviews,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
