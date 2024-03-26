import 'package:flutter/material.dart';
import 'package:yoyak/styles/colors/palette.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';

class BaseInput extends StatelessWidget {
  final String title;
  final Widget child;

  const BaseInput({
    super.key,
    required this.title,
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
              title,
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
