import 'package:flutter/material.dart';
import 'package:yoyak/components/base_button.dart';
import 'package:yoyak/components/rounded_rectangle.dart';
import 'package:yoyak/components/search_filter.dart';
import 'package:yoyak/screen/Search/filter_result_screen.dart';
import 'package:yoyak/screen/Search/text_search_screen.dart';
import '../../styles/colors/palette.dart';

class FilterSearchScreen extends StatefulWidget {
  const FilterSearchScreen({super.key});

  @override
  State<FilterSearchScreen> createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  // 선택된 옵션을 저장하는 Map
  // Map<String, FilterContainer> selectedOptions = {};
  final List<Map<String, dynamic>> filterOptions = [
    {
      'options': {
        '모양     전체': null,
        '원형': 'assets/images/shapes/circle.png',
        '타원형': 'assets/images/shapes/ellipse.png',
        '반원형': 'assets/images/shapes/half_circle.png',
        '삼각형': 'assets/images/shapes/triangle.png',
        '사각형': 'assets/images/shapes/square.png',
        '마름모': 'assets/images/shapes/rhombus.png',
        '장방형': 'assets/images/shapes/rectangle.png',
        '오각형': 'assets/images/shapes/pentagon.png',
        '육각형': 'assets/images/shapes/hexagon.png',
        '팔각형': 'assets/images/shapes/octagon.png',
        '기타': 'assets/images/shapes/etc.png',
      },
      'default': '모양     전체',
    },
    {
      'options': {
        '색상     전체': null,
        '하양': 'assets/images/colors/white.png',
        '노랑': 'assets/images/colors/yellow.png',
        '주황': 'assets/images/colors/orange.png',
        '분홍': 'assets/images/colors/pink.png',
        '빨강': 'assets/images/colors/red.png',
        '갈색': 'assets/images/colors/brown.png',
        '연두': 'assets/images/colors/lightgreen.png',
        '초록': 'assets/images/colors/green.png',
        '청록': 'assets/images/colors/turquoise.png',
        '파랑': 'assets/images/colors/blue.png',
        '남색': 'assets/images/colors/indigo.png',
        '자주': 'assets/images/colors/wine.png',
        '보라': 'assets/images/colors/purple.png',
        '회색': 'assets/images/colors/grey.png',
        '검정': 'assets/images/colors/black.png',
        '투명': 'assets/images/colors/none.png',
      },
      'default': '색상     전체',
    },
    {
      'options': {
        '제형     전체': null,
        '정제류': 'assets/images/pills/none.png',
        '경질캡슐': 'assets/images/pills/hard.png',
        '연질캡슐': 'assets/images/pills/soft.png',
      },
      'default': '제형     전체',
    },
    {
      'options': {
        '분할선 전체': null,
        '없음': 'assets/images/lines/none.png',
        '(-)형': 'assets/images/lines/minus.png',
        '(+)형': 'assets/images/lines/plus.png',
        '기타': 'assets/images/lines/etc2.png',
      },
      'default': '분할선 전체',
    },
  ];

  @override
  void initState() {
    super.initState();
    // _resetSelectedOptions();
  }

  // 선택 옵션을 초기화하는 메서드
  // void _resetSelectedOptions() {
  //   setState(() {
  //     for (var fiterOption in filterOptions) {
  //       var defaultFilterContainer = FilterContainer(
  //         text: fiterOption['default'],
  //       );
  //       selectedOptions[fiterOption['default']] = defaultFilterContainer;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // options을 포함하는 리스트

    return Scaffold(
      appBar: AppBar(
        title: const Text('알약 검색',
            style: TextStyle(
              color: Palette.MAIN_BLACK,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 15,
            )),
        backgroundColor: Palette.BG_BLUE,
        centerTitle: true,
        toolbarHeight: 55,
      ),
      body: Container(
        width: double.infinity,
        color: Palette.BG_BLUE,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "필터로 알약 검색",
                  style: TextStyle(
                      color: Palette.MAIN_BLACK,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: RoundedRectangle(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.10,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TextSearchScreen()));
                  },
                  boxShadow: const [
                    BoxShadow(
                      color: Palette.SHADOW_GREY,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ],
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.search,
                        color: Palette.MAIN_BLUE,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "약의 이름, 증상을 입력해주세요",
                        style: TextStyle(color: Palette.SUB_BLACK),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // filterOptions 순회하면서 FilterComponent 출력
              // type을 List<FilterContainer>로 바꿔줌

              // selectedOptions를 이용하여 현재 선택된 옵션을 전달
              // default로 선택된 옵션을 전달
              ...filterOptions.map<Widget>((filterOption) {
                var options =
                    filterOption['options'].entries.map<FilterContainer>((e) {
                  return FilterContainer(imagePath: e.value, text: e.key);
                }).toList();

                return FilterComponent(
                  options: options,
                  selectedOption: options.firstWhere(
                      (option) => option.text == filterOption['default']),
                  // selectedOption: selectedOptions[filterOption['default']]!,
                  onSelectionChanged: (newSelection) {
                    print('Selected option: ${newSelection.text}');
                  },
                );
              }),
              // 초기화, 검색하기 버튼
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 45),
                child: Row(
                  children: [
                    BaseButton(
                      onPressed: () {
                        setState(() {
                          // _resetSelectedOptions();
                          // 초기화 버튼을 누르면 다시 rebuild
                          Navigator.pushReplacement(
                            // 현재 화면을 스택에서 제거하고 새로운 화면을 띄움
                            context,
                            PageRouteBuilder(
                              // 커스텀 페이지 전환
                              // context : 현재의 build context
                              pageBuilder: (context, animation1, animation2) =>
                                  const FilterSearchScreen(),
                              transitionDuration:
                                  const Duration(seconds: 0), // 화면전환 애니메이션 X
                            ),
                          );
                        });
                      },
                      text: '초기화',
                      // colorMode: 'blue',
                      colorMode: 'white',
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    BaseButton(
                      // selectedOptions을 get으로 보내기
                      // 결과를 상태관리에 저장
                      // 그 후 검색 결과 화면으로 이동
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FilterResult()));
                      },
                      text: '검색하기',
                      colorMode: 'blue',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget filterComponent(BuildContext context) {
    return Container(
      child: RoundedRectangle(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.width * 0.25,
        boxShadow: const [
          BoxShadow(
            color: Palette.SHADOW_GREY,
            blurRadius: 3,
            offset: Offset(0, 2),
          )
        ],
        child: const Row(),
      ),
    );
  }
}
