import 'package:flutter/material.dart';

class RoundedRectangle extends StatelessWidget {
  final double width, height;
  final destination;
  // final Color color;
  final Widget child;
  const RoundedRectangle({super.key, required this.width, required this.height, required this.child, required this.destination});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => destination));
    },

      child: Container (
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(
          //   width: 0.1,
          //   color: Colors.white,
          // ),
          // boxShadow: [
          //   BoxShadow(
          //       color: Color(0x00b5b5b5).withOpacity(0.1),
          //       offset: Offset(0.1, 0.1),
          //       blurRadius: 3// 그림자 위치 조정
          //   ),
          // ]
        ),
        width: width,
        height: height,
        child: child,
      )
    );
  }
}