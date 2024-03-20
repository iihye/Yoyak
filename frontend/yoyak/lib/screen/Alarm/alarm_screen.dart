import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yoyak/components/BaseButton.dart';
import 'package:yoyak/components/RoundedRectangle.dart';
import 'package:yoyak/screen/Alarm/alarm_create.dart';
import 'package:yoyak/styles/colors/palette.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  MediaQueryData? queryData;

  var data = [
    {
      "notiTimeSeq": 1,
      "name": "감기약이다",
      "time": "2024-03-18T10:00:00",
      "taken": "TAKEN",
      "takenTime": "2024-03-18T13:00:00",
      "accountSeq": 1,
      "notiSeq": 12
    },
    {
      "notiTimeSeq": 2,
      "name": "감기약이다",
      "time": "2024-03-18T13:00:00",
      "taken": "NOT_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 12
    },
    {
      "notiTimeSeq": 3,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 12
    },
    {
      "notiTimeSeq": 4,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 12
    },
    {
      "notiTimeSeq": 5,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 12
    },
    {
      "notiTimeSeq": 6,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 12
    },
  ];

  @override
  Widget build(BuildContext context) {
    double paddingValue = MediaQuery.of(context).size.width * 0.03;
    return Scaffold(
      // 배경색
      backgroundColor: Palette.BG_BLUE,
      appBar: AppBar(
        // AppBar 배경색
        backgroundColor: Palette.BG_BLUE,
        // AppBar의 제목
        title: const Center(
          child: Text(
            '알림 관리',
            style: TextStyle(
              color: Palette.MAIN_BLACK,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
        toolbarHeight: 55,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingValue),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            TableCalendar(
              locale: 'ko_KR',
              headerVisible: false,
              calendarFormat: _calendarFormat,
              firstDay: DateTime.utc(2024, 03, 10),
              lastDay: DateTime.utc(2024, 04, 06),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                // 기본 달력 스타일
                // defaultTextStyle: const TextStyle(
                //   color: Palette.MAIN_BLACK,
                //   fontSize: 15,
                //   fontFamily: 'Pretendard',
                //   fontWeight: FontWeight.w500,
                // ),
                // defaultDecoration: const BoxDecoration(
                //   color: Colors.black,
                //   shape: BoxShape.circle,
                // ),

                // 오늘 날짜 스타일
                todayDecoration: BoxDecoration(
                  color: Palette.MAIN_BLUE,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),

                // 선택된 날짜의 테두리 스타일
                selectedDecoration: BoxDecoration(
                  color: Palette.SUB_BLUE,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Palette.MAIN_BLACK,
                  fontSize: 15,
                ),
              ),
              // 달력의 요일 스타일
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Palette.MAIN_BLACK,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
                weekendStyle: TextStyle(
                  color: Palette.MAIN_BLACK,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  ...data.map<Widget>((alarm) {
                    int notiTimeSeq = alarm['notiTimeSeq'] as int;
                    String name = alarm['name'] as String;
                    DateTime time = DateTime.parse(alarm['time'] as String);
                    String taken = alarm['taken'] as String;
                    DateTime? takenTime = alarm['takenTime'] != null
                        ? DateTime.parse(alarm['takenTime'] as String)
                        : null;
                    int accountSeq = alarm['accountSeq'] as int;
                    int notiSeq = alarm['notiSeq'] as int;

                    return AlarmItem(
                      notiTimeSeq: notiTimeSeq,
                      name: name,
                      time: time,
                      taken: taken,
                      takenTime: takenTime,
                      accountSeq: accountSeq,
                      notiSeq: notiSeq,
                    );
                  }),
                  SizedBox(
                    // 없으면 카드 좌우 그림자가 짤림
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AlarmCreateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// 알림 리스트 아이템
class AlarmItem extends StatelessWidget {
  final int notiTimeSeq;
  final String name;
  final DateTime time;
  final String taken;
  final DateTime? takenTime;
  final int accountSeq;
  final int notiSeq;

  const AlarmItem({
    super.key,
    required this.notiTimeSeq,
    required this.name,
    required this.time,
    required this.taken,
    required this.takenTime,
    required this.accountSeq,
    required this.notiSeq,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void goToAlarmUpdate(int? notiSeq) {
      Navigator.push(
        context,
        MaterialPageRoute(
          // 수정 할 것
          builder: (context) => AlarmCreate(notiSeq: notiSeq),
        ),
      );
      print(notiSeq);
    }

    String formatTime(DateTime time) {
      String period = time.hour < 12 ? '오전' : '오후';
      int hour = time.hour <= 12 ? time.hour : time.hour - 12;
      String minute = time.minute.toString().padLeft(2, '0');
      return '$period $hour:$minute';
    }

    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.03,
      ),
      child: RoundedRectangle(
        onTap: () {
          // 수정페이지로 이동하게 해야함 ** 서버에서 받아온 notiSeq 데이터를 넘겨줘야함
          goToAlarmUpdate(notiSeq);
        },
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100,
        // 알림 상세 화면으로 이동시켜야 할듯
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.10,
            right: screenWidth * 0.03,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              taken == 'TAKEN'
                  ? Text(
                      name,
                      style: const TextStyle(
                          color: Palette.MAIN_BLUE,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700),
                    )
                  : taken == 'NOT_TAKEN'
                      ? Text(
                          name,
                          style: const TextStyle(
                              color: Palette.SUB_BLACK,
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        )
                      : Text(
                          name,
                          style: const TextStyle(
                              color: Palette.MAIN_BLACK,
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        ),
              taken == 'TAKEN'
                  ? Text(
                      formatTime(time),
                      style: const TextStyle(
                          color: Palette.MAIN_BLUE,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700),
                    )
                  : taken == 'YET_TAKEN'
                      ? Text(
                          formatTime(time),
                          style: const TextStyle(
                              color: Palette.MAIN_BLACK,
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        )
                      : Text(
                          formatTime(time),
                          style: const TextStyle(
                              color: Palette.SUB_BLACK,
                              fontSize: 15,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700),
                        ),
              CheckEatPillButton(
                taken: taken,
                takenTime: takenTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 알림 생성 버튼
class AlarmCreateButton extends StatelessWidget {
  const AlarmCreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void goToAlarmCreate(int? notiSeq) {
      Navigator.push(
        context,
        MaterialPageRoute(
          // 수정 할 것
          builder: (context) => AlarmCreate(notiSeq: notiSeq),
        ),
      );
    }

    return BaseButton(
      width: 80,
      height: 40,
      child: FloatingActionButton(
        onPressed: () {
          goToAlarmCreate(null);
        },
        backgroundColor: Palette.MAIN_BLUE,
        child: const Padding(
          padding: EdgeInsets.only(right: 4.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white, size: 23),
              Text(
                '알림',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckEatPillButton extends StatelessWidget {
  final String taken;
  final DateTime? takenTime;

  const CheckEatPillButton({
    super.key,
    required this.taken,
    this.takenTime,
  });

  String eatenTime(DateTime time) {
    String period = time.hour < 12 ? '오전' : '오후';
    int hour = time.hour <= 12 ? time.hour : time.hour - 12;
    String minute = time.minute.toString().padLeft(2, '0');
    return '$period $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoundedRectangle(
        width: 68,
        height: 64,
        color: taken == 'TAKEN' ? Palette.SUB_BLUE : Palette.SUB_WHITE,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            taken == 'TAKEN'
                ? const Icon(Icons.check, color: Palette.MAIN_BLUE, size: 36)
                : taken == 'YET_TAKEN'
                    ? Image.asset(
                        'assets/images/medicine.png',
                        width: 38,
                        height: 38,
                      )
                    : const Icon(Icons.close,
                        color: Palette.SUB_BLACK, size: 33),
            taken == 'TAKEN'
                ? Text(
                    eatenTime(takenTime as DateTime),
                    style: const TextStyle(
                        color: Palette.MAIN_BLUE,
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700),
                  )
                : taken == 'YET_TAKEN'
                    ? const SizedBox(
                        height: 3,
                      )
                    : const Text('건너 뛰었어요',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          color: Palette.SUB_BLACK,
                        )),
          ],
        ),
        onTap: () {
          modal(context);
        },
      ),
    );
  }

  Future<void> modal(BuildContext context) {
    Widget modalContent;
    switch (taken) {
      case 'TAKEN':
        modalContent = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('약을 복용했습니다.'),
            ElevatedButton(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
        break;
      case 'NOT_TAKEN':
        modalContent = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('약을 복용하지 않았습니다.'),
            ElevatedButton(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
        break;
      case 'YET_TAKEN':
        modalContent = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('아직 약을 복용할 시간이 아닙니다.'),
            ElevatedButton(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
        break;
      default:
        modalContent = const Text('정보가 없습니다.');
        break;
    }

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(child: modalContent),
        );
      },
    );
  }
}
