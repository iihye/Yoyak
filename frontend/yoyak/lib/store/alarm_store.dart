import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/apis/url.dart';
import 'package:yoyak/models/alarm/alarm_models.dart';
import 'package:yoyak/store/login_store.dart';

class AlarmStore extends ChangeNotifier {
  List<AlarmModel> alarms = [];

  Future<void> getAlarmDatas() async {
    String yoyakURL = API.yoyakUrl; // 서버 URL
    String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyU2VxIjoyLCJ1c2VySWQiOiJzc2FmeTJAc3NhZnkuY29tIiwibmFtZSI6InNzYWZ5MiIsIm5pY2tuYW1lIjoic3NhZnkyIiwiZ2VuZGVyIjoiTSIsImlhdCI6MTcxMTU5OTYwOSwiZXhwIjoxNzk3OTk5NjA5fQ.vErWofXd1kTZUJ2LGYAxf6SmgBuf7gV4yxcyoNlf-FM'; // 액세스 토큰
    String url = '$yoyakURL/noti/time'; // 요청할 URL

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var decodedBody = utf8.decode(response.bodyBytes);
        List<dynamic> data = json.decode(decodedBody);
        alarms = data.map((json) => AlarmModel.fromJson(json)).toList();
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
