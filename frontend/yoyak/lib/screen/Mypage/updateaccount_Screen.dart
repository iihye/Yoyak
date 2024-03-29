import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:yoyak/apis/url.dart';
import 'package:yoyak/models/user/accountdetail_models.dart';
import 'package:yoyak/store/login_store.dart';

class UpdateAccountScreen extends StatefulWidget {
  final int? accountSeq;
  final bool isUser;
  const UpdateAccountScreen({
    super.key,
    required this.accountSeq,
    required this.isUser,
  });

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  late int seq;
  late String name;
  late String nickname;
  late String gender;
  late String birth;
  late String disease;
  late int profileImg;

  late TextEditingController _userNameController;
  

  Future<void> fetchAlarmData(int accountSeq) async {
    String yoyakURL = API.yoyakUrl; // 서버 URL
    String accessToken = context.read<LoginStore>().accessToken;
    String url = '$yoyakURL/account/detail/$accountSeq';
    Uri uri = Uri.parse(url);

    try {
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $accessToken',
      });
      if (response.statusCode == 200) {
        var decodedBody = utf8.decode(response.bodyBytes);
        var jsonData = json.decode(decodedBody);

        // AlarmDetailModels 객체로 변환
        AccountDetailModel alarmDetails = AccountDetailModel.fromJson(jsonData);

        setState(() {
          seq = alarmDetails.seq!;
          name = alarmDetails.name!;
          nickname = alarmDetails.nickname!;
          gender = alarmDetails.gender!;
          birth = alarmDetails.birth!;
          disease = alarmDetails.disease ?? '없음';
          profileImg = alarmDetails.profileImg ?? 0;

          print(
            'seq: $seq, name: $name, nickname: $nickname, gender: $gender, birth: $birth, disease: $disease, profileImg: $profileImg',
          );
        });
      } else {
        print('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      // 예외 처리
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.accountSeq != null) {
      fetchAlarmData(widget.accountSeq!);
    }
    print('지금 유저 인가요? ${widget.isUser}');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
