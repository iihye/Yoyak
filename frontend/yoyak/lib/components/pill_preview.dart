import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/screen/Search/pill_detail_screen.dart';
import '../styles/colors/palette.dart';

class PillPreview extends StatelessWidget {
  final String imgPath;
  final String itemName;
  final String entpName;
  final int medicineSeq;
  final Function()? onTap;

  const PillPreview({
    super.key,
    required this.imgPath,
    required this.itemName,
    required this.medicineSeq,
    required this.entpName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap 상세정보 페이지로 이동(mediaSeq 전달)
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PillDetailScreen(medicineSeq: medicineSeq),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: RoundedRectangle(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.20,
          boxShadow: const [
            BoxShadow(
              color: Palette.SHADOW_GREY,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ],
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              // 사진 크기, 둥글기는 API 받아오면 그때 다시 설정하자
              ClipRRect(
                // 자식요소 크기 강제 설정
                borderRadius: BorderRadius.circular(17),
                // db에서 이미지를 받아오는 거 고민
                child: Image.network(
                  imgPath,
                  // width: 100,
                  width: MediaQuery.of(context).size.width * 0.25,
                  // height: 55,
                  height: MediaQuery.of(context).size.width * 0.13,
                  // .cover: 이미지 비율 유지하면서 이미지 크기 조절(이미지 잘림, 근데 둥글게 가능)
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis, // 길이 초과하면 ...
                    itemName,
                    style: const TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    entpName,
                    style: const TextStyle(
                      color: Palette.SUB_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
