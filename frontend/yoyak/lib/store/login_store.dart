import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yoyak/apis/url.dart';
import 'package:yoyak/screen/Login/kakao_login.dart';
import 'package:yoyak/screen/Login/kakao_view_model.dart';
import 'package:http/http.dart' as http;

class LoginStore extends ChangeNotifier {
  String accessToken = '';
  var UserDetail; // 회원정보 페이지에 뿌려줄 데이터

  // 회원가입 정보
  String userName = '성현';
  String userEmail = '';
  String password = '';

  // 생년 월일
  String year = '';
  String month = '';
  String day = '';

  // 성별 : enum Type / 남자 : 'MAN', 여자 : 'WOMAN'
  String gender = '';

  setGender(String str) {
    print("성별 $str");
    gender = str;
  }

  setYear(String str) {
    print("년도 $str");
    year = str;
  }

  setMonth(String str) {
    print("월 $str");
    month = str;
  }

  setDay(String str) {
    print("일 $str");
    day = str;
  }

  setAccessToken(token) {
    accessToken = token;
  }
}
