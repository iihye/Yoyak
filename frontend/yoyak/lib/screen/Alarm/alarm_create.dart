import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoyak/styles/colors/palette.dart';

class AlarmCreate extends StatefulWidget {
  final int? notiSeq;
  const AlarmCreate({
    super.key,
    this.notiSeq,
  });

  @override
  State<AlarmCreate> createState() => _AlarmCreateState();
}

class _AlarmCreateState extends State<AlarmCreate> {
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(2024, 03, 30),
  );

  final _formKey = GlobalKey<FormState>();
  final String _alarmName = '';
  final DateTime _alarmTime = DateTime.now();
  final String _alarmDuration = '';

  @override
  void dispose() {
    print(_alarmTime);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(_alarmTime);
    print(widget.notiSeq);
  }

  checkAlarmName() {
    print('$_alarmName, $_alarmTime, $_alarmDuration');
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;

    return Scaffold(
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
                          '${start.year % 100}.${start.month.toString().padLeft(2, '0')}.${start.day}'),
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
