import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/components/pill_bag.dart';
import 'package:yoyak/store/login_store.dart';
import '../../styles/colors/palette.dart';
import 'package:yoyak/components/base_input.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';
import 'package:yoyak/components/account_filter.dart';
import 'package:yoyak/components/base_button.dart';
import 'package:yoyak/components/pill_bag_dialog.dart';

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

class PillBagModal extends StatefulWidget {
  const PillBagModal({super.key});

  @override
  State<PillBagModal> createState() => _PillBagModalState();
}

class _PillBagModalState extends State<PillBagModal> {
  int? _selectedAccountSeq;

  @override
  Widget build(BuildContext context) {
    var accountList = context.watch<LoginStore>().alarmAccounts;
    return RoundedRectangle(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 1.5,
      color: Palette.MAIN_WHITE,
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
                      // 실시간 반영을 위한 StatefulBuilder
                      return StatefulBuilder(builder: (context, setState) {
                        return const PillBagDialog();
                      });
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
  }
}
