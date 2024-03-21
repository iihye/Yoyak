import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yoyak/styles/colors/palette.dart';

class AlarmCreate extends StatefulWidget {
  final int? notiSeq;

  const AlarmCreate({
    super.key,
    required this.notiSeq,
  });

  @override
  State<AlarmCreate> createState() => _AlarmCreateState();
}

class _AlarmCreateState extends State<AlarmCreate> {
  var data = [
    {
      "accountSeq": 1,
      "notiSeq": 4,
      "name": "감기약3",
      "startDate": "2024-01-03",
      "endDate": "2024-01-05",
      "period": ["MONDAY", "TUESDAY", "WEDNESDAY"],
      "time": ["09:00:00", "13:00:00", "20:00:00"]
    }
  ];

  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(2024, 03, 30),
  );

  final _formKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   print(_alarmTime);
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   print(_alarmTime);
  //   print(widget.notiSeq);
  //   checkAlarmName();
  // }

  // checkAlarmName() {
  //   print('$_alarmName, $_alarmTime, $_alarmDuration');
  // }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    '알람 이름',
                    style: TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        selectDateRange();
                      },
                      child: Text(
                        '${start.year % 100}.${start.month.toString().padLeft(2, '0')}.${start.day}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        selectDateRange();
                      },
                      child: Text(
                          '${end.year % 100}.${end.month.toString().padLeft(2, '0')}.${end.day}'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selectDateRange() async {
    await showDateRangePicker(
      context: context,
      firstDate: dateTimeRange.start,
      lastDate: DateTime(2025),
    );
  }
}
