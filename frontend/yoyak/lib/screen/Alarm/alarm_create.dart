import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:yoyak/components/base_button.dart';
import 'package:yoyak/components/base_input.dart';
import 'package:yoyak/components/bottom_modal.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/components/selectday_button.dart';
import 'package:yoyak/hooks/format_time.dart';
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
  final _formKey = GlobalKey<FormState>();
  late String _alarmName = '';
  late DateTime _alarmStartDate = DateTime.now();
  late DateTime _alarmEndDate = DateTime.now();
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  late List<String> _alarmDays = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];
  late List<DateTime> _alarmTime = [];
  // 주기 관련 변수
  late bool isEveryday = true;

  late TextEditingController _alarmNameController;
  var data = [
    {
      "accountSeq": 1,
      "notiSeq": 4,
      "name": "감기약",
      "startDate": "2024-04-06",
      "endDate": "2024-04-10",
      "period": ["MONDAY", "TUESDAY", "WEDNESDAY"],
      "time": ["09:00:00", "13:00:00", "20:00:00"]
    }
  ];

  @override
  void initState() {
    super.initState();

    if (widget.notiSeq != null) {
      // notiSeq와 일치하는 알림 데이터 찾기
      var alarmData = data.firstWhere(
        (element) => element['notiSeq'] == widget.notiSeq,
        orElse: () => <String, Object>{},
      );

      // 해당 데이터로 폼 채우기
      _alarmName = (alarmData['name'] as String?) ?? '';
      print(_alarmName);
      _alarmNameController =
          TextEditingController(text: alarmData['name'] as String? ?? '');
      _alarmStartDate =
          DateTime.parse(alarmData['startDate'] as String? ?? '2020-01-01');
      _alarmEndDate =
          DateTime.parse(alarmData['endDate'] as String? ?? '2020-01-01');
      _alarmDays = (alarmData['period'] as List<dynamic>?)
              ?.map((day) => day as String)
              .toList() ??
          [];
      _alarmTime =
          (alarmData['time'] as List<dynamic>? ?? []).map<DateTime>((timeStr) {
        var timeParts = (timeStr as String).split(':');
        dateTimeRange =
            DateTimeRange(start: _alarmStartDate, end: _alarmEndDate);
        return DateTime(
          _alarmStartDate.year,
          _alarmStartDate.month,
          _alarmStartDate.day,
          int.parse(timeParts[0]),
          int.parse(timeParts[1]),
          int.parse(timeParts[2]),
        );
      }).toList();
    } else {
      // notiSeq가 null일 때 (새 알림 생성)
      _alarmNameController = TextEditingController();
    }
  }

  void handleEverydaySelected() {
    setState(() {
      isEveryday = true;
      _alarmDays.clear();
    });
  }

  void handleSpecificDaySelected() {
    setState(() {
      if (isEveryday) {
        _alarmDays.clear();
        isEveryday = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
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
                BaseInput(title: '알림 이름', child: alarmnameInput()),
                // 여백
                const SizedBox(
                  height: 20,
                ),
                // 기간
                BaseInput(
                  title: '알림 기간',
                  child: GestureDetector(
                    onTap: () async {
                      await selectDateRange();
                    },
                    child: RoundedRectangle(
                      width: ScreenSize.getWidth(context) * 0.85,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_alarmStartDate.year}.${_alarmStartDate.month}.${_alarmStartDate.day}        ~        ${_alarmEndDate.year}.${_alarmEndDate.month}.${_alarmEndDate.day}',
                            style: const TextStyle(
                              color: Palette.MAIN_BLACK,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // 주기
                BaseInput(
                  title: '알림 요일',
                  child: InputSelectDay(
                    selectedDays: _alarmDays,
                    isEveryday: isEveryday,
                    onEverydaySelected: handleEverydaySelected,
                    onSpecificDaySelected: handleSpecificDaySelected,
                    onDaysChanged: (updatedDays) {
                      setState(() {
                        _alarmDays = updatedDays;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // 알림 시간
                const Row(
                  children: [
                    // input 값 이름 왼쪽 여백
                    SizedBox(width: 20),

                    // input 값 이름
                    Text(
                      '알림 시간',
                      style: TextStyle(
                        color: Palette.MAIN_BLUE,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                alarmTimeList(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    BaseButton(
                      width: ScreenSize.getWidth(context) * 0.67,
                      onPressed: () {
                        timeSelectorModal(
                            context: context,
                            time: null,
                            onTimeSelected: (selectedTime) {
                              setState(() {
                                _alarmTime = List.from(_alarmTime)
                                  ..add(selectedTime);
                              });
                            });
                      },
                      text: '시간 추가 +',
                      colorMode: 'blue',
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
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
          bool isFormValid = _formKey.currentState!.validate();
          if (!isFormValid) {
            // 폼의 필드 중 하나라도 유효하지 않은 경우
            return; // 더 이상 진행하지 않음
          }

          // 폼의 모든 TextFormField의 onSaved를 호출
          _formKey.currentState!.save();

          // 필수 필드 확인
          if (_alarmName.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Palette.MAIN_RED,
                content: Text(
                  '알람 이름을 입력해주세요.',
                  style: TextStyle(
                    color: Palette.MAIN_WHITE,
                    fontSize: 16,
                    fontFamily: 'pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }

          if (_alarmDays.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Palette.MAIN_RED,
                content: Text(
                  '알람 요일을 선택해주세요.',
                  style: TextStyle(
                    color: Palette.MAIN_WHITE,
                    fontSize: 16,
                    fontFamily: 'pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
          if (_alarmTime.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Palette.MAIN_RED,
                content: Text('시간을 추가해주세요.',
                    style: TextStyle(
                      color: Palette.MAIN_WHITE,
                      fontSize: 16,
                      fontFamily: 'pretendard',
                      fontWeight: FontWeight.w500,
                    )),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }

          print(
              '$_alarmName, $_alarmTime, $_alarmStartDate, $_alarmEndDate, $_alarmDays');
          // 추가적인 작업 수행...
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

  // 알림 이름 입력
  Widget alarmnameInput() {
    return TextFormField(
      controller: _alarmNameController,
      // autofocus: true,
      maxLength: 10,
      cursorHeight: 20,
      cursorColor: Palette.MAIN_BLUE,
      style: const TextStyle(
        color: Palette.MAIN_BLACK,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(
          left: 15,
          bottom: 10,
          top: 10,
        ),
        // placeholder
        hintText: '알람 이름을 입력해주세요.',
        // 글자수 제한 안내문구 삭제
        counterText: '',
      ),
      onSaved: (value) {
        _alarmName = value!;
      },
    );
  }

  Future selectDateRange() async {
    DateTimeRange? newRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      initialDateRange: dateTimeRange,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Palette.MAIN_BLUE, // 선택된 날짜 및 확인 버튼 색상
              secondary: Palette.SUB_BLUE,
            ),
            textTheme: const TextTheme(
              // 달력 상단 텍스트 스타일
              titleLarge: TextStyle(
                color: Palette.MAIN_BLACK,
                fontSize: 23,
                fontWeight: FontWeight.w500,
                fontFamily: 'Pretendard',
              ),
              // 달력 상단 작은 텍스트 스타일
              titleSmall: TextStyle(
                color: Palette.MAIN_BLACK,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Pretendard',
              ),

              // 기간 입력 텍스트 스타일
              bodyLarge: TextStyle(
                color: Palette.MAIN_BLACK,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Pretendard',
              ),

              // 달력 텍스트 스타일
              bodyMedium: TextStyle(
                color: Palette.MAIN_BLACK,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 'Pretendard',
              ),
              // 버튼 텍스트 스타일
              labelLarge: TextStyle(
                color: Palette.MAIN_BLACK,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Pretendard',
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newRange != null) {
      setState(() {
        dateTimeRange = newRange;
        _alarmStartDate = newRange.start; // 시작 날짜 업데이트
        _alarmEndDate = newRange.end; // 종료 날짜 업데이트
      });
    }
  }

  Future<void> timeSelectorModal({
    required BuildContext context,
    required DateTime? time,
    required Function(DateTime) onTimeSelected,
  }) {
    time ??= DateTime.now();

    int selectedHour;
    int selectedMinute = time.minute;
    int selectedPeriodIndex = time.hour < 12 ? 0 : 1;

    if (time.hour == 0) {
      // 자정은 12시로 표시
      selectedHour = 12;
    } else if (time.hour > 12) {
      // 오후 시간 변환
      selectedHour = time.hour - 12;
    } else {
      selectedHour = time.hour;
    }

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                              '알림 시간',
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
                        // 선택된 시간을 DateTime 객체로 변환
                        DateTime selectedTime = DateTime(
                          _alarmStartDate.year,
                          _alarmStartDate.month,
                          _alarmStartDate.day,
                          selectedPeriodIndex == 0
                              ? selectedHour
                              : selectedHour + 12,
                          selectedMinute,
                        );

                        // 중복 체크
                        if (!_alarmTime.contains(selectedTime)) {
                          // 중복이 아니면 리스트에 추가하고 시간 순으로 정렬
                          onTimeSelected(selectedTime);
                          _alarmTime.sort((a, b) => a.compareTo(b));
                        } else {
                          // 중복인 경우, 사용자에게 알림 표시
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Palette.MAIN_RED,
                              content: Text(
                                "이미 추가된 시간입니다.",
                                style: TextStyle(
                                  color: Palette.MAIN_WHITE,
                                  fontSize: 16,
                                  fontFamily: 'pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }

                        Navigator.pop(context);
                      },
                      child: Text(
                        selectedPeriodIndex == 0
                            ? '오전 $selectedHour : ${selectedMinute.toString().padLeft(2, '0')}'
                            : '오후 $selectedHour : ${selectedMinute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Palette.MAIN_WHITE,
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

  Widget alarmTimeList() {
    return Column(
      children: _alarmTime.map((time) {
        return AlarmItem(
          alarmTime: time,
          onDelete: () {
            setState(() {
              _alarmTime.remove(time);
            });
          },
          onEdit: () {
            timeSelectorModal(
              context: context,
              time: time,
              onTimeSelected: (selectedTime) {
                int index = _alarmTime.indexOf(time);
                if (index != -1) {
                  setState(() {
                    _alarmTime[index] = selectedTime;
                    _alarmTime.sort((a, b) => a.compareTo(b));
                  });
                }
              },
            );
          },
        );
      }).toList(),
    );
  }
}

class InputSelectDay extends StatelessWidget {
  final List<String> selectedDays;
  final bool? isEveryday;
  final Function onEverydaySelected;
  final Function() onSpecificDaySelected;
  final Function(List<String>) onDaysChanged;

  const InputSelectDay({
    super.key,
    required this.selectedDays,
    required this.isEveryday,
    required this.onEverydaySelected,
    required this.onSpecificDaySelected,
    required this.onDaysChanged,
  });

  String getFormattedDays() {
    Map<String, int> dayOrder = {
      'MONDAY': 1,
      'TUESDAY': 2,
      'WEDNESDAY': 3,
      'THURSDAY': 4,
      'FRIDAY': 5,
      'SATURDAY': 6,
      'SUNDAY': 7,
    };

    Map<String, String> dayMap = {
      'MONDAY': '월',
      'TUESDAY': '화',
      'WEDNESDAY': '수',
      'THURSDAY': '목',
      'FRIDAY': '금',
      'SATURDAY': '토',
      'SUNDAY': '일',
    };

    List<String> sortedDays = List.from(selectedDays)
      ..sort((a, b) => dayOrder[a]!.compareTo(dayOrder[b]!));

    return sortedDays.map((day) => dayMap[day]!).join(', ');
  }

  bool isEverydaySelected() {
    List<String> allDays = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY'
    ];

    return selectedDays.toSet().containsAll(allDays.toSet());
  }

  Future<void> selectDayModal({
    required BuildContext context,
    required List<String> selectedDays,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomModal(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 알람 이름
                    Text(
                      '알림 요일',
                      style: TextStyle(
                        color: Palette.MAIN_BLUE,
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        List<String> allDays = [
                          'MONDAY',
                          'TUESDAY',
                          'WEDNESDAY',
                          'THURSDAY',
                          'FRIDAY',
                          'SATURDAY',
                          'SUNDAY'
                        ];
                        onEverydaySelected();
                        onDaysChanged(allDays); // 모든 요일 선택
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: ScreenSize.getWidth(context) * 0.85,
                        color: Palette.MAIN_WHITE,
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          '매일 알림',
                          style: TextStyle(
                            color: Palette.MAIN_BLACK,
                            fontSize: 16,
                            fontFamily: 'pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Palette.SUB_BLACK,
                  height: 20,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: ScreenSize.getWidth(context) * 0.85,
                        color: Palette.MAIN_WHITE,
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          '특정 요일',
                          style: TextStyle(
                            color: Palette.MAIN_BLACK,
                            fontSize: 16,
                            fontFamily: 'pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        print('if 전 $selectedDays $isEveryday');
                        if (isEveryday != null && isEveryday == true) {
                          selectedDays.clear();
                          onSpecificDaySelected();
                        }

                        print(' $selectedDays');
                        showSpecificDayModal(
                            context: context, selectedDays: selectedDays);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showSpecificDayModal({
    required BuildContext context,
    required List<String> selectedDays,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomModal(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Palette.MAIN_BLACK,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          '특정 요일',
                          style: TextStyle(
                            color: Palette.MAIN_BLACK,
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        onDaysChanged(selectedDays);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '완료',
                        style: TextStyle(
                          color: Palette.MAIN_BLUE,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectedDay(
                      day: 'SUNDAY',
                      selectedDays: selectedDays,
                    ),
                    SelectedDay(day: 'MONDAY', selectedDays: selectedDays),
                    SelectedDay(day: 'TUESDAY', selectedDays: selectedDays),
                    SelectedDay(day: 'WEDNESDAY', selectedDays: selectedDays),
                    SelectedDay(day: 'THURSDAY', selectedDays: selectedDays),
                    SelectedDay(day: 'FRIDAY', selectedDays: selectedDays),
                    SelectedDay(day: 'SATURDAY', selectedDays: selectedDays),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 빈 공간 선택 시 반응
      behavior: HitTestBehavior.opaque,
      onTap: () {
        selectDayModal(context: context, selectedDays: selectedDays);
      },
      child: SizedBox(
        width: ScreenSize.getWidth(context),
        height: 100,
        child: Center(
          child: Text(
            isEverydaySelected() ? '매일 알림' : getFormattedDays(),
            style: const TextStyle(
              color: Palette.MAIN_BLACK,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class AlarmItem extends StatelessWidget {
  final DateTime alarmTime;
  final Function onDelete;
  final Function onEdit;

  const AlarmItem({
    super.key,
    required this.alarmTime,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () => onEdit(),
              child: RoundedRectangle(
                width: ScreenSize.getWidth(context) * 0.67,
                boxShadow: const [],
                height: 40,
                border: Border.all(
                  color: Palette.MAIN_BLUE,
                  width: 1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatTime(alarmTime),
                      style: const TextStyle(
                        color: Palette.MAIN_BLACK,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: ScreenSize.getWidth(context) * 0.05,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Palette.MAIN_RED,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Palette.MAIN_WHITE,
                  size: 25,
                ),
                onPressed: () => onDelete(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
