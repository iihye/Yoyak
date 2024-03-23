import 'package:flutter/material.dart';
import 'package:yoyak/styles/colors/palette.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';

class BaseInput extends StatelessWidget {
  final String placeholder;
  final Widget child;

  const BaseInput({
    super.key,
    required this.placeholder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // input 값 이름 왼쪽 여백
            const SizedBox(width: 20),

            // input 값 이름
            Text(
              placeholder,
              style: const TextStyle(
                color: Palette.MAIN_BLUE,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: ScreenSize.getWidth(context) * 0.85,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Palette.MAIN_BLUE,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// TextFormField(
//               autofocus: true,
//               maxLength: 10,
//               cursorColor: Palette.MAIN_BLUE,
//               style: const TextStyle(
//                 color: Palette.MAIN_BLACK,
//                 fontFamily: 'Pretendard',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.only(left: 15, bottom: 8),
//                 // placeholder
//                 hintText: '알람 이름을 입력해주세요.',
//                 // 글자수 제한 안내문구 삭제
//                 counterText: '',
//               ),
//               onSaved: (value) {
//                 _alarmName = value!;
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return '알람 이름을 입력해주세요';
//                 }
//                 return null;
//               },
//             ),