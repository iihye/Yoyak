import 'package:flutter/material.dart';
import 'package:yoyak/screen/Alarm/alarm_screen.dart';
import 'package:yoyak/screen/Login/kakao_login.dart';
import 'package:yoyak/screen/Login/kakao_view_model.dart';
import 'package:yoyak/styles/colors/palette.dart';

class KakaoLoginScreen extends StatefulWidget {
  const KakaoLoginScreen({super.key});

  @override
  State<KakaoLoginScreen> createState() => _KakaoLoginScreenState();
}

class _KakaoLoginScreenState extends State<KakaoLoginScreen> {
  final viewModel = KakaoViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    var inputWidth = MediaQuery.of(context).size.width * 0.82;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // 0xFFF5F6F9
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                SizedBox(
                  height: 80,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Palette.MAIN_BLUE.withOpacity(0.95),
                    ),
                    width: inputWidth,
                    height: 55,
                    child: TextButton(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.mail_sharp, color: Colors.white),
                          SizedBox(
                            width: 85,
                          ),
                          Text(
                            "카카오 로그인",
                            style: TextStyle(
                                fontFamily: "Pretendard",
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        // 카카오 로그인 누를 때 로직
                        await viewModel.login();
                      },
                    )),
                SizedBox(
                  height: 30,
                ),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        // 요약 로고 넣기
        // Image(
        //   image: AssetImage('assets/logo/pillin_logo.png'),
        //   width: 300,
        // ),
        Icon(
          Icons.adb,
          size: 130,
          color: Palette.MAIN_BLUE,
        ),
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "요약 회원이 아니신가요? ",
          style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 13),
        ),
        GestureDetector(
          child: Text(
            "회원가입",
            style: TextStyle(color: Palette.MAIN_BLUE, fontSize: 13),
          ),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => AlarmScreen(),
                transitionsBuilder: (c, a1, a2, child) => FadeTransition(
                  opacity: a1,
                  child: child,
                ),
                transitionDuration: Duration(milliseconds: 700),
              ),
            );
          },
        )
      ],
    );
  }
}
