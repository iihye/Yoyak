import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/components/base_button.dart';
import 'package:yoyak/models/alarm/alarm_models.dart';
import 'package:yoyak/models/user/account_models.dart';
import 'package:yoyak/screen/Login/kakao_login_screen.dart';
import 'package:yoyak/screen/Mypage/mypage_screen.dart';
import 'package:yoyak/store/login_store.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, this.color});
  final color;

  @override
  Size get preferredSize => const Size.fromHeight(10 + kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    List<AccountModel> account = context.watch<LoginStore>().alarmAccounts;

    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: color,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/logo.png"),
          account.isEmpty
              ? BaseButton(
                  text: "로그인하기",
                  width: 120,
                  colorMode: 'white',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KakaoLoginScreen(),
                      ),
                    );
                  })
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MypageScreen()));
                  },
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.asset(
                        "assets/images/profiles/profile${account.first.profileImg}.png"),
                  ),
                )
        ],
      ),
    );
  }
}
