import 'package:flutter/material.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('필터 검색'),
      ),
      body: Center(
        child: Text("필터 검색화면"),
      ),
    );
  }
}
