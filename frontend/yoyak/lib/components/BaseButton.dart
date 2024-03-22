import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final double width, height;
  final Widget child;
  final Function()? onTap;
  final Color? color;
  final List<BoxShadow>? boxShadow;

// width, height 필수
// child 필수
// color 커스텀 가능 (기본 설정 O - white)
// onTap 커스텀 가능 (기본 설정 X)
// boxShadow 커스텀 가능 (기본 설정 O)

  const BaseButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.color,
    this.onTap,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 0.1,
            color: Colors.white,
          ),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
        ),
        width: width,
        height: height,
        child: child,
      )
    );
  }
}
