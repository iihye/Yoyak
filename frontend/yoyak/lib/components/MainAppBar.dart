import 'package:flutter/material.dart';

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
          children: [
            Text("요약")
          ],
        )
    );
  }
}
