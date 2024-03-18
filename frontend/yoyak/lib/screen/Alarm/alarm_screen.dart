import 'package:flutter/material.dart';
import 'package:yoyak/styles/colors/palette.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        "알람 페이지임",
        style: TextStyle(
          color: Palette.MAIN_BLUE,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
