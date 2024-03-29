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

}