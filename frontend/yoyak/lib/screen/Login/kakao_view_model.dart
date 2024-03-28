import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yoyak/screen/Home/home_screen.dart';
import 'package:yoyak/screen/Login/social_login.dart';
import 'package:http/http.dart' as http;
import 'package:yoyak/screen/SignUp/greeting_screen.dart';
import '../../apis/url.dart';

// 뷰 모델
class KakaoViewModel {
  final BuildContext context;
  final SocialLogin _socialLogin; // 로그인 or 로그아웃
  bool isLogined = false; // 로그인 여부
  User? user; // 유저

  // 구글, 애플 등 로그인도 쓸 수 있으니까 생성자의 매개변수로 추상 클래스를 넣어줌
  KakaoViewModel(this._socialLogin, this.context);

  Future sendKakaoId (kakaoId) async {
    try {
      var url = "${API.yoyakUrl}/user/login/kakao";
      var response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      }, body: json.encode({
        "id" : kakaoId,
      }));
      print(response.body);
      // 회원가입이 안되었을 때 회원가입 화면으로 보내기
      Navigator.push(
        context,
        MaterialPageRoute(
          builder : (context) => const GreetingScreen(),
        ),
      );
    } catch (error) {
      print("카카오 토큰 전송 실패");
      print(error);
    }
  }



  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print("user다 : $user");
      sendKakaoId(user?.id);
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}