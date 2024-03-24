import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yoyak/components/bottom_modal.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/hooks/format_time.dart';
import 'package:yoyak/screen/Alarm/alarm_create.dart';
import 'package:yoyak/styles/colors/palette.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';

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
      "takenTime": "2024-03-18T12:20:00",
      "accountSeq": 1,
      "notiSeq": 4
    },
    {
      "notiTimeSeq": 2,
      "name": "감기약이다",
      "time": "2024-03-18T13:00:00",
      "taken": "NOT_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 4
    },
    {
      "notiTimeSeq": 3,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 4
    },
    {
      "notiTimeSeq": 4,
      "name": "감기약이다",
      "time": "2024-03-18T00:01:00",
      "taken": "TAKEN",
      "takenTime": "2024-03-18T00:03:00",
      "accountSeq": 1,
      "notiSeq": 4
    },
    {
      "notiTimeSeq": 5,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 4
    },
    {
      "notiTimeSeq": 6,
      "name": "감기약이다",
      "time": "2024-03-18T18:00:00",
      "taken": "YET_TAKEN",
      "takenTime": null,
      "accountSeq": 1,
      "notiSeq": 4
    },
  ];

  @override
  Widget build(BuildContext context) {
    double paddingValue = ScreenSize.getWidth(context) * 0.03;
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
            SizedBox(height: ScreenSize.getHeight(context) * 0.02),
            TableCalendar(
              locale: 'ko_KR',
              headerVisible: false,
              calendarFormat: _calendarFormat,
              firstDay: DateTime.utc(2024, 01, 01),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('필터자리 (계정이 여러개가 있을 경우만 나올것)')],
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
      print('왔니 $notiSeq');
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
                name: name,
                time: time,
                taken: taken,
                takenTime: takenTime,
                notiSeq: notiSeq,
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

    return SizedBox(
      width: 80,
      height: 43,
      child: FloatingActionButton(
        backgroundColor: Palette.MAIN_BLUE,
        elevation: 3,
        onPressed: () {
          goToAlarmCreate(null);
        },
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

// 복용 체크 버튼
class CheckEatPillButton extends StatefulWidget {
  final String name;
  final DateTime time;
  final String taken;
  final int notiSeq;
  final DateTime? takenTime;

  const CheckEatPillButton({
    super.key,
    required this.name,
    required this.time,
    required this.taken,
    required this.notiSeq,
    this.takenTime,
  });

  @override
  _CheckEatPillButtonState createState() => _CheckEatPillButtonState();
}

class _CheckEatPillButtonState extends State<CheckEatPillButton> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    DateTime time = widget.time;
    String taken = widget.taken;
    int notiSeq = widget.notiSeq;
    DateTime? takenTime = widget.takenTime;

    return Center(
      child: RoundedRectangle(
        width: 68,
        height: 64,
        color: taken == 'TAKEN' ? Palette.SUB_BLUE : Palette.SUB_WHITE,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 여백
            const SizedBox(height: 5),

            // 버튼 아이콘
            taken == 'TAKEN'
                ? const Icon(Icons.check, color: Palette.MAIN_BLUE, size: 36)
                : taken == 'YET_TAKEN'
                    ? Image.asset(
                        'assets/images/medicine.png',
                        width: 44,
                        height: 44,
                      )
                    : const Icon(Icons.close,
                        color: Palette.SUB_BLACK, size: 33),

            // 버튼 텍스트
            taken == 'TAKEN'
                ? Text(
                    formatTime(takenTime as DateTime),
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
                    : const Text(
                        '건너 뛰었어요',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          color: Palette.SUB_BLACK,
                        ),
                      ),
          ],
        ),
        onTap: () {
          checkeatpillmodal(
            context: context,
            name: name,
            time: time,
            notiSeq: notiSeq,
            takenTime: takenTime,
          );
        },
      ),
    );
  }

  Future<void> checkeatpillmodal({
    required BuildContext context,
    required String name,
    required DateTime time,
    required int notiSeq,
    required DateTime? takenTime,
  }) {
    Widget modalContent;
    switch (widget.taken) {
      // 약 복용을 했을 때
      case 'TAKEN':
        modalContent = Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 알람 이름
                  Text(
                    name,
                    style: const TextStyle(
                      color: Palette.MAIN_BLUE,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  // 복용 시간
                  Text(
                    formatTime(time),
                    style: const TextStyle(
                      color: Palette.MAIN_BLUE,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 먹지 않았어요 버튼
                  RoundedRectangle(
                    width: 110,
                    height: 100,
                    // 나중에 수정 api 연결
                    onTap: () => {Navigator.pop(context)},
                    color: Palette.SUB_WHITE,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, color: Palette.SUB_BLACK, size: 55),
                        Text(
                          '먹지 않았어요',
                          style: TextStyle(
                            color: Palette.SUB_BLACK,
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: ScreenSize.getWidth(context) * 0.1,
                  ),

                  // 시간 수정 버튼
                  RoundedRectangle(
                    width: 110,
                    height: 100,
                    color: Palette.SUB_BLUE,
                    onTap: () {
                      timeSelectorModal(
                        context: context,
                        notiSeq: notiSeq,
                        takenTime: takenTime as DateTime,
                      );
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/retime.png'),
                          width: 50,
                          height: 57,
                        ),
                        Text(
                          '시간 수정',
                          style: TextStyle(
                            color: Palette.MAIN_BLUE,
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;

      // 약 복용을 하지 않았을 때
      case 'NOT_TAKEN':
        modalContent = Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 알람 이름
                  Text(
                    name,
                    style: const TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  // 복용 시간
                  Text(
                    formatTime(time),
                    style: const TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 먹지 않았어요 버튼
                  RoundedRectangle(
                    width: 110,
                    height: 100,
                    // 나중에 수정 api 연결
                    onTap: () => {Navigator.pop(context)},
                    color: Palette.SUB_WHITE,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, color: Palette.SUB_BLACK, size: 55),
                        Text(
                          '건너뛰기 취소',
                          style: TextStyle(
                            color: Palette.SUB_BLACK,
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;

      // 아직 복용하지 않은 경우
      case 'YET_TAKEN':
        modalContent = Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 알람 이름
                  Text(
                    name,
                    style: const TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  // 복용 시간
                  Text(
                    formatTime(time),
                    style: const TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 건너 뛰었어요 버튼
                  RoundedRectangle(
                    width: 110,
                    height: 100,
                    color: Palette.SUB_WHITE,
                    onTap: () => {Navigator.pop(context)},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, color: Palette.SUB_BLACK, size: 55),
                        Text(
                          '건너 뛰었어요',
                          style: TextStyle(
                            color: Palette.SUB_BLACK,
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: ScreenSize.getWidth(context) * 0.1,
                  ),

                  // 먹었어요 버튼
                  RoundedRectangle(
                    width: 110,
                    height: 100,
                    color: Palette.SUB_BLUE,
                    onTap: () => {
                      Navigator.pop(context),
                      // 이걸 담아서 주면 됨
                      print(
                        DateTime.now(),
                      )
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: Palette.MAIN_BLUE, size: 55),
                        Text(
                          '먹었어요',
                          style: TextStyle(
                            color: Palette.MAIN_BLUE,
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;

      // 기본 값
      default:
        modalContent = const Text('정보가 없습니다.');
        break;
    }

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomModal(child: modalContent);
      },
    );
  }

  Future<void> timeSelectorModal({
    required BuildContext context,
    required int notiSeq,
    required DateTime takenTime,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // 초기 시간 설정
        int selectedHour =
            widget.takenTime!.hour % 12 == 0 ? 12 : widget.takenTime!.hour % 12;
        int selectedMinute = widget.takenTime!.minute;
        int selectedPeriodIndex = widget.takenTime!.hour < 12 ? 0 : 1;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return RoundedRectangle(
              height: 380,
              width: ScreenSize.getWidth(context),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '복용 시간',
                              style: TextStyle(
                                color: Palette.MAIN_BLUE,
                                fontSize: 20,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Palette.SUB_BLUE.withOpacity(0.5),
                                  ),
                                  width: ScreenSize.getWidth(context) * 0.85,
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    // 오전/오후 선택기
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        NumberPicker(
                                          infiniteLoop: true,
                                          value: selectedPeriodIndex,
                                          minValue: 0,
                                          maxValue: 1,
                                          itemCount: 2,
                                          itemHeight: 40,
                                          textMapper: (String value) {
                                            return value == '0' ? '오전' : '오후';
                                          },
                                          textStyle: const TextStyle(
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            color: Palette.MAIN_BLACK,
                                            fontSize: 18,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          selectedTextStyle: const TextStyle(
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            color: Palette.MAIN_BLACK,
                                            fontSize: 20,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedPeriodIndex = newValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    // 시간 선택기
                                    NumberPicker(
                                      infiniteLoop: true,
                                      value: selectedHour,
                                      minValue: 1,
                                      maxValue: 12,
                                      itemCount: 7,
                                      itemHeight: 40,
                                      textStyle: const TextStyle(
                                        textBaseline: TextBaseline.alphabetic,
                                        color: Palette.SUB_BLACK,
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      selectedTextStyle: const TextStyle(
                                        textBaseline: TextBaseline.alphabetic,
                                        color: Palette.MAIN_BLACK,
                                        fontSize: 20,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedHour = newValue;
                                        });
                                      },
                                    ),

                                    // 분 선택기
                                    NumberPicker(
                                      infiniteLoop: true,
                                      value: selectedMinute,
                                      minValue: 0,
                                      maxValue: 59,
                                      itemCount: 7,
                                      itemHeight: 40,
                                      textMapper: (String value) {
                                        return int.parse(value) < 10
                                            ? '0$value'
                                            : value;
                                      },
                                      textStyle: const TextStyle(
                                        color: Palette.SUB_BLACK,
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      selectedTextStyle: const TextStyle(
                                        color: Palette.MAIN_BLACK,
                                        fontSize: 20,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedMinute = newValue;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenSize.getWidth(context),
                    height: 50.8,
                    color: Palette.MAIN_BLUE,
                    child: TextButton(
                      onPressed: () {
                        // 시간 수정 api 연결
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text(
                        selectedPeriodIndex == 0
                            ? '오전 $selectedHour : ${selectedMinute.toString().padLeft(2, '0')}'
                            : '오후 $selectedHour : ${selectedMinute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
