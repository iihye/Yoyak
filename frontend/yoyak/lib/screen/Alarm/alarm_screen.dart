import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import statement
import 'package:table_calendar/table_calendar.dart';
import 'package:yoyak/styles/colors/palette.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('알림 관리',
              style: TextStyle(
                color: Palette.MAIN_BLACK,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                fontSize: 15,
              )),
        ),
        backgroundColor: Palette.BG_BLUE,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TableCalendar(
            headerVisible: false,
            calendarFormat: CalendarFormat.week,
            firstDay: DateTime.utc(2024, 03, 10),
            lastDay: DateTime.utc(2024, 04, 03),
            focusedDay: DateTime.now(),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
