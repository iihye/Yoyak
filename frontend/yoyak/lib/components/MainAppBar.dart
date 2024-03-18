import 'package:flutter/material.dart';
import 'package:yoyak/screen/Mypage/mypage_screen.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(10 + kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("요약"),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MypageScreen()));
              },
              child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("assets/images/person-image.png")),
            ),
          ],
        ));
  }
}
