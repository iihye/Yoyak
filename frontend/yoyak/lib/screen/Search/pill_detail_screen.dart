import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yoyak/components/base_button.dart';
import 'package:yoyak/components/base_input.dart';
import 'package:yoyak/components/pill_bag.dart';
import 'package:yoyak/components/pill_description.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';
import '../../styles/colors/palette.dart';

// 효능, 사용법, 보관방법, 경고, 주의사항, 부작용
final Map<String, dynamic> dummyDetailData = {
  "medicineSeq": 199907335,
  // "imagePath": "https://www.druginfo.co.kr/drugimg/251234.jpg",
  "imagePath": null,
  "itemName": "한미알마게이트정500밀리그램(알마게이트)",
  "entpName": "한미약품(주)",
  "efficacy": null,
  "useMethod":
      "성인 및 12세 이상의 소아는 1회 2정(1 g)을 1일 3회 식후 30분~1시간에 씹어서 복용합니다.필요시 취침 전에 1회 더 복용할 수 있습니다.",
  "depositMethod": "습기와 빛을 피해 실온에서 보관하십시오.어린이의 손이 닿지 않는 곳에 보관하십시오.",
  "atpnWarn": null,
  "atpn":
      "이 약에 과민증 환자, 알츠하이머병, 치질, 체액저류(부기), 임신중독증, 설사, 진단되지 않은 소화기관출혈 환자는 이 약을 복용하지 마십시오.이 약을 복용하기 전에 신장애, 신체 허약자, 인 함량이 낮은 식이요법 실시자, 소화흡수장애가 있는 사람, 고령자, 혈액구토 또는 흑색대변 등과 같은 소화기관출혈 증상이 있는 환자, 임부 또는 임신하고 있을 가능성이 있는 여성 및 수유부는 의사 또는 약사와 상담하십시오.정해진 용법과 용량을 잘 지키십시오.어린이에게 투여할 경우 보호자의 지도 감독하에 투여하십시오.2주정도 복용하여도 증상의 개선이 없을 경우 복용을 즉각 중지하고 의사 또는 약사와 상의하십시오.이 약에 과민증 환자, 알츠하이머병, 치질, 체액저류(부기), 임신중독증, 설사, 진단되지 않은 소화기관출혈 환자는 이 약을 복용하지 마십시오.",
  "sideEffect": "변비, 설사 등이 나타나는 경우 복용을 즉각 중지하고 의사 또는 약사와 상의하십시오."
};

// 약 봉투 dummy data
final Map<String, dynamic> dummyPillBags = {
  "count": 3,
  "result": [
    {
      "medicineEnvelopSeq": 1,
      "color": "0xfff59c42",
      "accountSeq": 1,
      "nickname": "지원",
      "isSavedMedicine": false,
      "envelopName": "감기약"
    },
    {
      "medicineEnvelopSeq": 2,
      "color": "0xff49de60",
      "accountSeq": 2,
      "nickname": "오지훈",
      "isSavedMedicine": false,
      "envelopName": "두통약 봉투"
    },
    {
      "medicineEnvelopSeq": 3,
      "color": "0xff4287f5",
      "accountSeq": 2,
      "nickname": "김성현",
      "isSavedMedicine": false,
      "envelopName": "상비약 봉투"
    }
  ]
};

class PillDetailScreen extends StatelessWidget {
  final int medicineSeq;

  const PillDetailScreen({
    super.key,
    required this.medicineSeq,
  });

  // 약 봉투 모달
  void _showPillBagModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // 위젯을 포함하는 함수
        return RoundedRectangle(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 1.5,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "약 봉투에 저장하기",
                    style: TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 70,
                  // ),
                  // 클릭 시, 약 봉투 생성
                  GestureDetector(
                    onTap: () {
                      // 약 봉투 생성 함수..?
                      print('약 봉투 생성');
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Palette.MAIN_WHITE,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BaseInput(
                                    title: "약 봉투 이름",
                                    width: ScreenSize.getWidth(context) * 0.675,
                                    // child: TextFormField(
                                    //   maxLength: 10,
                                    //   cursorHeight: 20,
                                    //   cursorColor: Palette.MAIN_BLUE,
                                    //   style: const TextStyle(
                                    //     color: Palette.MAIN_BLACK,
                                    //     fontFamily: 'Pretendard',
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                    child: const TextField(
                                      maxLength: 10,
                                      cursorHeight: 20,
                                      cursorColor: Palette.MAIN_BLUE,
                                      style: TextStyle(
                                        color: Palette.MAIN_BLACK,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 13,
                                          top: 13,
                                        ),
                                        counterText: '',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/images/pillbag.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              // 돌보미 필터

              // 약 봉투 리스트
              Column(
                children: [
                  for (var dummypillBag in dummyPillBags["result"])
                    PillBag(
                      envelopName: dummypillBag["envelopName"],
                      medicineSeq: 1,
                      accountSeq: dummypillBag["accountSeq"],
                      nickname: dummypillBag["nickname"],
                      isSavedMedicine: dummypillBag["isSavedMedicine"],
                      // 컬러코드로 받기
                      color: dummypillBag["color"],
                      onClick: () {
                        // 약 봉투에 저장하기 함수..?
                        print('클릭');
                      },
                    )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // medicineSeq를 이용해서 DB에서 알약 정보를 가져오기
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Palette.BG_BLUE,
        appBar: AppBar(
          title: const Text(
            '알약 상세 정보',
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(children: [
              // 알약 카드
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: RoundedRectangle(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.90,
                  boxShadow: const [
                    BoxShadow(
                      color: Palette.SHADOW_GREY,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ],
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.08,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: dummyDetailData["imagePath"] != null
                              ? Image.network(
                                  dummyDetailData["imagePath"],
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  height:
                                      MediaQuery.of(context).size.width * 0.30,
                                  fit: BoxFit.cover, // 모서리 각진거 이걸로 해결
                                )
                              : Image.asset(
                                  'assets/images/pillbox.jpg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  height:
                                      MediaQuery.of(context).size.width * 0.30,
                                  fit: BoxFit.cover,
                                )),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.07,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text(
                          dummyDetailData["itemName"],
                          style: const TextStyle(
                            color: Palette.MAIN_BLACK,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Text(
                        dummyDetailData["entpName"],
                        style: const TextStyle(
                          color: Palette.SUB_BLACK,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.07,
                      ),
                      // 저장하기 버튼
                      // 로그인 안됐을 때는 로그인 창으로 이동
                      BaseButton(
                        onPressed: () {
                          _showPillBagModal(context);
                        },
                        text: "저장하기",
                        colorMode: "blue",
                        width: 104,
                        height: 35,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              // 약 정보, 주의사항 탭
              const TabBar(
                tabs: [
                  Tab(
                    text: "약 정보",
                  ),
                  Tab(
                    text: "주의사항",
                  ),
                ],
                dividerColor: Palette.SHADOW_GREY,
                indicatorColor: Palette.MAIN_BLUE,
                unselectedLabelColor: Palette.SUB_BLACK,
                labelColor: Palette.MAIN_BLUE,
                overlayColor: MaterialStatePropertyAll(
                    Palette.BG_BLUE), // 탭 바 클릭 시 나오는 splash 컬러
              ),
              // TabBarView
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.width *
                    1.5, // 컨텐츠에 FIT하게 바꿀 수 있나..
                child: TabBarView(
                  children: [
                    // 약 정보
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 주의 bar
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 13, top: 10, bottom: 10),
                            child: RoundedRectangle(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              color: Palette.MAIN_BLUE,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/light.png",
                                    width: 30,
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // API로 데이터 받기
                                  const Text(
                                    "임신, 어린이 주의",
                                    style: TextStyle(
                                      color: Palette.MAIN_WHITE,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 효능효과 분기
                          if (dummyDetailData["efficacy"] != null)
                            PillDescription(
                              title: "효능효과",
                              description: dummyDetailData["efficacy"],
                            ),
                          if (dummyDetailData["useMethod"] != null)
                            PillDescription(
                              title: "사용 방법",
                              description: dummyDetailData["useMethod"],
                            ),
                          if (dummyDetailData["depositMethod"] != null)
                            PillDescription(
                              title: "보관 방법",
                              description: dummyDetailData["depositMethod"],
                            ),
                        ],
                      ),
                    ),
                    // 주의사항
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 주의 bar
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 13, top: 10, bottom: 10),
                            child: RoundedRectangle(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              color: Palette.MAIN_BLUE,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/light.png",
                                    width: 30,
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // API로 데이터 받기
                                  const Text(
                                    "임신, 어린이 주의",
                                    style: TextStyle(
                                      color: Palette.MAIN_WHITE,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // 효능효과 분기
                          if (dummyDetailData["atpnWarn"] != null)
                            PillDescription(
                              title: "경과",
                              description: dummyDetailData["atpnWarn"],
                            ),
                          if (dummyDetailData["atpn"] != null)
                            PillDescription(
                              title: "주의 사항",
                              description: dummyDetailData["atpn"],
                            ),
                          if (dummyDetailData["sideEffect"] != null)
                            PillDescription(
                              title: "부작용",
                              description: dummyDetailData["sideEffect"],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
