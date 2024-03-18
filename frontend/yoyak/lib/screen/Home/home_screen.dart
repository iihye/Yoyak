import 'package:flutter/material.dart';
import 'package:yoyak/components/MainAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Asdf", style: TextStyle(
              color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}
