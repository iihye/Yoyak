import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/screen/Main/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yoyak/security/Security.dart';
import 'package:yoyak/store/camera_store.dart';
import 'package:yoyak/store/login_store.dart';


void main() async {
  //Kakao SDK 초기화 : 카카오 Api 가져다 쓰려면 이렇게 초기화해줘야 함
  KakaoSdk.init(nativeAppKey: Security.NATIVE_APP_KEY);
  await initializeDateFormatting();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CameraStore()),
        ChangeNotifierProvider(create: (context) => LoginStore()),
        // 다른 스토어도 이렇게 넣으면 됨
      ],
      child: const MyApp(),
    ),
  );
}

  class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ko', ''),
          Locale('en', ''),
        ],
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      )
    );
  }
}
