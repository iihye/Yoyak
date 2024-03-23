import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yoyak/components/base_input.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/styles/colors/palette.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';

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
  late String _alarmName = '';
  late final List<DateTime> _alarmTime = [];
  late final DateTime _alarmStartDate = DateTime.now();
  late final DateTime _alarmEndDate = DateTime.now();
  late final List<String> _alarmDuration = [];

  @override
  Widget build(BuildContext context) {
    // final start = DateTime.now();
    // final end = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 여백
              const SizedBox(
                height: 10,
              ),

              // 알림 이름
              BaseInput(placeholder: '알림 이름', child: alarmnameInput()),

              // 여백
              const SizedBox(
                height: 20,
              ),

              // 주기
              Column(
                children: [
                  const inputLabel(title: '주기'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedRectangle(
                        width: ScreenSize.getWidth(context) * 0.85,
                        height: 40,
                        onTap: () {
                          setState(() {
                            _alarmDuration.clear();
                            _alarmDuration.add('매일');
                          });
                        },
                        color: Palette.WHITE_BLUE,
                        boxShadow: const [],
                        child: const Center(
                          child: Text(
                            '매일',
                            style: TextStyle(
                              color: Palette.MAIN_BLACK,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(ScreenSize.getWidth(context), 48),
          backgroundColor: Palette.MAIN_BLUE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // 폼의 모든 TextFormField의 onSaved를 호출
            _formKey.currentState!.save();

            // 이제 _alarmName, _alarmTime 등에 사용자의 입력값이 저장되어 있습니다.
            print(
              '$_alarmName, $_alarmTime, $_alarmStartDate, $_alarmEndDate, $_alarmDuration',
            );
          }
        },
        child: const Center(
          child: Text(
            '완료',
            style: TextStyle(
              color: Palette.MAIN_WHITE,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget alarmnameInput() {
    return TextFormField(
      autofocus: true,
      maxLength: 10,
      cursorColor: Palette.MAIN_BLUE,
      style: const TextStyle(
        color: Palette.MAIN_BLACK,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 15, bottom: 8),
        // placeholder
        hintText: '알람 이름을 입력해주세요.',
        // 글자수 제한 안내문구 삭제
        counterText: '',
      ),
      onSaved: (value) {
        _alarmName = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '알람 이름을 입력해주세요';
        }
        return null;
      },
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

class inputLabel extends StatelessWidget {
  const inputLabel({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        const SizedBox(width: 20),
        InputName(title: title),
      ],
    );
  }
}

class InputName extends StatelessWidget {
  const InputName({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Palette.MAIN_BLACK,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}

class InputSelectDay extends StatelessWidget {
  const InputSelectDay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [],
    );
  }
}
