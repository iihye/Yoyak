import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/components/bottom_bar.dart';
import 'package:yoyak/models/user/alarm_account.dart';
import 'package:yoyak/screen/Alarm/alarm_screen.dart';
import 'package:yoyak/screen/Challenge/challenge_screen.dart';
import 'package:yoyak/screen/Search/photo_search_screen.dart';
import 'package:yoyak/store/alarm_store.dart';
import 'package:yoyak/store/login_store.dart';
import '../Home/home_screen.dart';

// MainScreen
// - AlarmScreen, HomeScreen, ChallengeScreen을 담고 있는 Screen
// BottomBar를 여기에 둬서 사용자가 탭할 때 index를 변화시켜 이동시킬 것임
// bottomBar는 재사용성을 위해 Component로 뺐음.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var curTabIdx = 1;
  final mainTabs = [
    const AlarmScreen(),
    const HomeScreen(),
    const ChallengeScreen(),
  ];

  // tabIdx 수정
  setCurTabIdx(int idx) {
    setState(() {
      print(idx);
      curTabIdx = idx;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AlarmStore>(context, listen: false).getAlarmDatas();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginStore>(context, listen: false).getAccountData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainTabs[curTabIdx],
      bottomNavigationBar: BottomBar(
        curTabIdx: curTabIdx,
        setCurTabIdx: setCurTabIdx,
        mainTabs: mainTabs,
      ),
    );
  }
}
