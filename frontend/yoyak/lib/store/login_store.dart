import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yoyak/apis/url.dart';
import 'package:http/http.dart' as http;
import 'package:yoyak/models/user/alarm_account.dart';
import 'package:yoyak/screen/Login/kakao_login.dart';
import 'package:yoyak/screen/Login/kakao_view_model.dart';

class LoginStore extends ChangeNotifier {
  late User user;
  List<AlarmAccountModel> alarmAccounts = [];

  Future<void> getAccountData() async {
    String yoyakURL = API.yoyakUrl; // 서버 URL
    String accessToken = API.yoyakToken; // 액세스 토큰
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
}
