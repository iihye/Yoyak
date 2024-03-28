import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/screen/SignUp/greeting_screen.dart';
import 'package:yoyak/store/login_store.dart';
import 'package:yoyak/styles/colors/palette.dart';

import '../Login/login_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String email = '';
  String password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  bool isValidEmail(String email) {
    // 정규 표현식을 사용하여 이메일 형식 검사
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidate() {
    if (emailController.text.isEmpty) {
      // Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        shape: RoundedRectangleBorder(
          // ShapeDecoration을 사용하여 borderRadius 적용
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "이메일을 입력해주세요",
          style: TextStyle(color: Palette.MAIN_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return false;
    } else if (!isValidEmail(emailController.text)) {
      // Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        shape: RoundedRectangleBorder(
          // ShapeDecoration을 사용하여 borderRadius 적용
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "올바른 이메일 형식이 아니에요",
          style: TextStyle(color: Palette.MAIN_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return false;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        shape: RoundedRectangleBorder(
          // ShapeDecoration을 사용하여 borderRadius 적용
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "비밀번호를 입력해주세요",
          style: TextStyle(color: Palette.MAIN_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inputWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lotties/cat.json',
                      width: 200, height: 200),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: '안녕하세요 ',
                          style: TextStyle(
                            fontSize: 22,
                            color: Palette.MAIN_BLACK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '${context.watch<LoginStore>().userName}님',
                          style: const TextStyle(
                            color: Palette.MAIN_BLUE, // 영양이 부분의 색상을 빨간색으로 지정
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // const TextSpan(
                        //   text: '님이군요!',
                        //   style: TextStyle(
                        //     fontSize: 26,
                        //     color: Palette.MAIN_BLACK,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const Text(
                    "아래 정보를 입력해주세요",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
              Column(
                children: [
                  // 이메일 입력란
                  Container(
                      width: inputWidth,
                      height: 60,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey.shade200, width: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.SHADOW_GREY.withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: TextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocusNode);
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "이메일을 입력해주세요.",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  // 이메일 입력란
                  Container(
                      width: inputWidth,
                      height: 60,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey.shade200, width: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.SHADOW_GREY.withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: TextField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "비밀번호를 입력해주세요.",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //회원가입 시 개인정보 수집 동의
                    // GestureDetector(
                    //   onTap: () async {
                    //     showPersonalAgreementDialog(context );
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(10.0),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         width: 0.7,
                    //         color: Colors.redAccent,
                    //       ),
                    //       color: Colors.white,
                    //     ),
                    //     child: Text(
                    //       '[필수] 개인정보 수집 동의',
                    //       style: TextStyle(
                    //         color: Colors.redAccent, // 텍스트의 색상
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // // 닉네임 다시 설정
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       PageRouteBuilder(
                    //         pageBuilder: (c, a1, a2) => GreetingScreen(),
                    //         transitionsBuilder: (c, a1, a2, child) =>
                    //             SlideTransition(
                    //           position: Tween(
                    //             begin: Offset(-1.0, 0.0),
                    //             end: Offset(0.0, 0.0),
                    //           )
                    //               .chain(CurveTween(curve: Curves.easeInOut))
                    //               .animate(a1),
                    //           child: child,
                    //         ),
                    //         transitionDuration: Duration(milliseconds: 750),
                    //       ),
                    //     );
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(10.0),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         width: 0.7,
                    //         color: Colors.redAccent,
                    //       ),
                    //       color: Colors.white,
                    //     ),
                    //     child: Text(
                    //       '이름 바꿀래요',
                    //       style: TextStyle(
                    //         color: Colors.redAccent, // 텍스트의 색상
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 10),
                    // 회원가입 요청
                    GestureDetector(
                      onTap: () async {

                        // await showPersonalAgreementDialog(context);
                        // if (!agreement) {
                        //   // agreement가 false인 경우 메시지를 띄움
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text('개인정보 수집 동의가 필요합니다.'),
                        //   ));
                        //   return; // 등록 작업을 중단
                        // }

                        // agreement가 true인 경우 사용자 정보 입력 값의 유효성 검사를 수행
                        if (!isValidate()) {
                          return; // 등록 작업을 중단
                        }

                        //회원가입 요청
                        try {
                          context.read<LoginStore>().userEmail = email;
                          context.read<LoginStore>().password = password;

                          if (isValidate()) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            // 회원가입 성공 시 이름이랑 닉네임 페이지 사라지게
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => const GreetingScreen(),
                                transitionsBuilder: (c, a1, a2, child) =>
                                    SlideTransition(
                                      position: Tween(
                                        begin: const Offset(-1.0, 0.0),
                                        end: const Offset(0.0, 0.0),
                                      )
                                          .chain(
                                          CurveTween(curve: Curves.easeInOut))
                                          .animate(a1),
                                      child: child,
                                    ),
                                transitionDuration: const Duration(milliseconds: 750),
                              ),
                            );
                          }
                        } catch (e) {
                          // Vibration.vibrate(duration: 300); // 진동
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            shape: RoundedRectangleBorder(
                              // ShapeDecoration을 사용하여 borderRadius 적용
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                            content: Text(
                              "이미 가입된 이메일입니다!",
                              style: TextStyle(color: Palette.MAIN_BLACK
                              ),
                            ),
                            backgroundColor: Colors.yellow,
                            duration: Duration(milliseconds: 1100),
                          ));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Palette.MAIN_BLUE, // 원의 배경색
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            color: Colors.white, // 텍스트의 색상
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}