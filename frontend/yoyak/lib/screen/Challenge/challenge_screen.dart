import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:yoyak/components/my_challenge_card.dart';
import 'package:yoyak/screen/Challenge/regist_challenge_screen.dart';
import 'package:yoyak/store/challenge_store.dart';
import 'package:yoyak/styles/colors/palette.dart';
import 'package:yoyak/styles/screenSize/screen_size.dart';
import '../../components/base_button.dart';
import '../../components/dialog.dart';
import '../../components/other_challenge_card.dart';
import '../../hooks/goto_screen.dart';
import '../../store/camera_store.dart';
import '../../store/login_store.dart';
import '../Login/login_screen.dart';
import '../Mypage/mypage_screen.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with WidgetsBindingObserver {
  String accessToken = '';

  Future<void> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken =
          prefs.getString('accessToken') ?? ''; // accessToken state 업데이트
    });
  }

  @override
  void initState() {
    super.initState();
    getAccessToken();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getAccessToken();
    context.read<ChallengeStore>().getMyChallenge(accessToken); // 내 챌린지 호출
    context.read<ChallengeStore>().getMyChallengeList(); // 내 챌린지 덱 호출
    context
        .read<ChallengeStore>()
        .getOthersChallenge(accessToken); // 챌린지 둘러보기 호출
    context.read<ChallengeStore>().getAllChallenge();
    var loginedUser = context.watch<LoginStore>().loginedUser;

    return Scaffold(
      backgroundColor: Palette.BG_BLUE,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: ScreenSize.getWidth(context),
              height: 250,
              color: Palette.MAIN_WHITE,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: _ChallengeTitleSection(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  // FutureBuilder 삭제하고 그 안의 내용을 그대로 MyChallengeCard로 옮김
                  if (accessToken.isNotEmpty)
                    MyChallengeCard(
                      title: "${loginedUser?.nickname}님이 진행 중인 챌린지",
                      titleImagePath: "assets/images/medal.png",
                    ),

                  const SizedBox(
                    height: 15,
                  ),

                  const OtherChallengeCard(
                    title: "챌린지 둘러보기",
                    titleImagePath: "assets/images/medal.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeTitleSection extends StatelessWidget {
  const _ChallengeTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    var myChallengeList =
        context.watch<ChallengeStore>().myChallengeList; // 내 첼린지 목록
    var myChallengeCard =
        context.watch<ChallengeStore>().myChallengeCard; // 내 첼린지 덱
    var getImageAndNavigate = context.read<CameraStore>().getImageAndNavigate;

    // 챌린지를 시작하지 않은 경우
    if (myChallengeCard.length == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "꾸준한 복용을 위해",
            style: TextStyle(
              fontSize: 20,
              color: Palette.SUB_BLACK.withOpacity(0.5),
              fontWeight: FontWeight.w400,
              fontFamily: 'Pretendard',
            ),
          ),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
              text: '새로운 ',
              style: TextStyle(
                fontSize: 27,
                color: Palette.MAIN_BLACK,
                fontWeight: FontWeight.w400,
                fontFamily: 'Pretendard',
              ),
            ),
            TextSpan(
              text: '챌린지',
              style: TextStyle(
                fontSize: 27,
                color: Palette.MAIN_BLUE,
                fontWeight: FontWeight.w700,
                fontFamily: 'Pretendard',
              ),
            ),
            TextSpan(
              text: '를',
              style: TextStyle(
                fontSize: 27,
                color: Palette.MAIN_BLACK,
                fontWeight: FontWeight.w400,
                fontFamily: 'Pretendard',
              ),
            ),
          ])),
          const Text(
            "시작해보세요",
            style: TextStyle(
              fontSize: 27,
              color: Palette.MAIN_BLACK,
              fontWeight: FontWeight.w400,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MypageScreen()));
            },
            child: SizedBox(
                width: 120,
                height: 33,
                child: BaseButton(
                  height: 40,
                  fontSize: 15,
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    prefs.getString('accessToken') != null
                        ? goToScreen(
                            context, const RegistChallengeScreen()) // 로그인 되어있다면
                        : showDialog(
                            context: context,
                            builder: (context) {
                              // 로그인 안되어있을 경우
                              return const DialogUI(
                                destination: LoginScreen(
                                  destination: RegistChallengeScreen(),
                                ),
                              );
                            });
                  },
                  text: "시작하기",
                  colorMode: 'white',
                  borderWidth: 1.0,
                  borderRadius: BorderRadius.circular(20),
                )),
          )
        ],
      );
    } else {
      Set<DateTime> challengeDateSet = Set();
      var totalDay = (myChallengeCard?["day"] ?? "0") + 1;

      for (int i = 0; i < myChallengeList.length; i++) {
        var createdDate = DateTime.parse(myChallengeList[i]['createdDate']);
        challengeDateSet.add(createdDate);
      }
      var completedRatio = challengeDateSet.length / totalDay;

      // 원본 날짜 문자열
      String startDateString = myChallengeCard["startDate"];
      String endDateString = myChallengeCard["endDate"];

// 날짜 문자열을 DateTime 객체로 파싱합니다.
      DateTime startDate = DateTime.parse(startDateString);
      DateTime endDate = DateTime.parse(endDateString);

// 날짜를 원하는 형식으로 포맷팅합니다.
      String formattedStartDate = DateFormat('M월 d일').format(startDate);
      String formattedEndDate = DateFormat('M월 d일').format(endDate);


      // 챌린지를 시작했다면
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "$formattedStartDate ~ $formattedEndDate",
                style: TextStyle(
                  fontSize: 17,
                  color: Palette.SUB_BLACK.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Pretendard',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    myChallengeCard["title"],
                    style: const TextStyle(
                      fontSize: 27,
                      color: Palette.MAIN_BLACK,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MypageScreen()));
                },
                child: SizedBox(
                    width: 130,
                    height: 33,
                    child: BaseButton(
                      height: 40,
                      fontSize: 15,
                      onPressed: () {
                        // 모달 창 나옴
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 170,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          // 사진 촬영 기능 구현
                                          getImageAndNavigate(
                                              ImageSource.camera, context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '사진 촬영',
                                              style: TextStyle(
                                                color: Palette.MAIN_BLUE,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 0.1,
                                      color: Palette.SHADOW_GREY,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          // 이미지 업로드 기능 구현
                                          getImageAndNavigate(
                                              ImageSource.gallery, context);
                                          // Navigator.pop(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '이미지 업로드',
                                              style: TextStyle(
                                                color: Palette.MAIN_BLUE,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      text: "챌린지 올리기",
                      colorMode: 'white',
                      borderWidth: 1.0,
                      borderRadius: BorderRadius.circular(20),
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "D-${totalDay-1}",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Palette.MAIN_BLUE,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard',
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: '현재까지 완료율   ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Palette.MAIN_BLACK,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  TextSpan(
                    text:
                        "${(completedRatio * 100).toInt()}",
                    style: const TextStyle(
                      fontSize: 30,
                      color: Palette.MAIN_BLACK,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  const TextSpan(
                    text: '%',
                    style: TextStyle(
                      fontSize: 17,
                      color: Palette.MAIN_BLACK,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ])),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Progress Bar
          AnimatedProgressBar(
            width: ScreenSize.getWidth(context) * 0.82,
            height: 10,
            value: completedRatio,
            duration: const Duration(seconds: 1),
            gradient: const LinearGradient(
              colors: [
                Colors.lightBlue,
                Palette.MAIN_BLUE,
              ],
            ),
            backgroundColor: Palette.SUB_BLACK.withOpacity(0.1),
          ),
        ],
      );
    }
  }
}
