import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:yoyak/apis/url.dart';
import 'package:yoyak/models/alarm/alarm_models.dart';

class AlarmStore extends ChangeNotifier {
  List<AlarmModel> alarms = [];

  Future<void> getAlarmDatas() async {
    String accessToken = access_token; // 액세스 토큰
    String url = '$URL/noti/time'; // 요청할 URL

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
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
