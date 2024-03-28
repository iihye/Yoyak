import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yoyak/apis/url.dart';
import 'package:http/http.dart' as http;
import 'package:yoyak/models/user/alarm_account.dart';
import 'package:yoyak/screen/Login/kakao_login.dart';
import 'package:yoyak/screen/Login/kakao_view_model.dart';
import 'package:http/http.dart' as http;

class LoginStore extends ChangeNotifier {
  late User user;
  List<AlarmAccountModel> alarmAccounts = [];
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyU2VxIjoyLCJ1c2VySWQiOiJzc2FmeTJAc3NhZnkuY29tIiwibmFtZSI6InNzYWZ5MiIsIm5pY2tuYW1lIjoic3NhZnkyIiwiZ2VuZGVyIjoiTSIsImlhdCI6MTcxMTU5OTYwOSwiZXhwIjoxNzk3OTk5NjA5fQ.vErWofXd1kTZUJ2LGYAxf6SmgBuf7gV4yxcyoNlf-FM';
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

  Future<void> getAccountData() async {
    String yoyakURL = API.yoyakUrl; // 서버 URL
    String url = '$yoyakURL/account'; // 요청할 URL

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print('Request succeeded! status: ${response.statusCode}.');
        var decodedBody = utf8.decode(response.bodyBytes);
        List<dynamic> data = json.decode(decodedBody);
        alarmAccounts =
            data.map((json) => AlarmAccountModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        // 오류 처리
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      // 예외 처리
      print('An error occurred: $error');
    }
  }

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
    notifyListeners();
  }
}
