import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yoyak/apis/url.dart';
import 'package:http/http.dart' as http;

class ChallengeStore extends ChangeNotifier {
  var yoyakUrl = API.yoyakUrl;

  List<dynamic> myChallengeList = [];

  Future getMyChallenge(accessToken) async {
      try {
        var response = await http.get(Uri.parse('$yoyakUrl/challenge/article/my'), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        print(yoyakUrl);
        print(response.body);
        print(accessToken);

        if (response.statusCode == 200) {
          myChallengeList = json.decode(response.body);
          notifyListeners();
        } else {
          print("내 챌린지 목록 조회 실패");
        }
      } catch (error) {
        print(error);
      }
  }
  
  Future registChallenge(String name, DateTime startDate, DateTime endDate, String accessToken, BuildContext context) async {
    try {
      String startMonth = "${startDate.month}".padLeft(2, "0");
      String startDay = "${startDate.day}".padLeft(2, "0");
      String endMonth = "${endDate.month}".padLeft(2, "0");
      String endDay = "${endDate.day}".padLeft(2, "0");

      var response = await http.post(Uri.parse("$yoyakUrl/challenge"), headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      }, body: json.encode({
        'title': name,
        'startDate': '${startDate.year}-$startMonth-$startDay',
        'endDate' : '${endDate.year}-$endMonth-$endDay',
      }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("챌린지 등록 성공");
        Navigator.pop(context);
      } else {
        print("챌린지 등록 실패");
      }


// DateTime(int.parse(year), int.parse(month), int.parse(day)).toIso8601String()
    } catch (error) {
      print(error);
      print("챌린지 등록 실패");
    }
  }

}