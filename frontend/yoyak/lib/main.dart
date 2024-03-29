import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:yoyak/screen/Main/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yoyak/security/Security.dart';
import 'package:yoyak/store/alarm_store.dart';
import 'package:yoyak/store/camera_store.dart';
import 'package:yoyak/store/challenge_store.dart';
import 'package:yoyak/store/login_store.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Kakao SDK 초기화 : 카카오 Api 가져다 쓰려면 이렇게 초기화해줘야 함
  KakaoSdk.init(nativeAppKey: Security.NATIVE_APP_KEY);
  await initializeDateFormatting();
  await dotenv.load(fileName: "assets/config/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CameraStore()),
        ChangeNotifierProvider(create: (context) => LoginStore()),
        ChangeNotifierProvider(create: (context) => AlarmStore()),
        ChangeNotifierProvider(create: (context) => ChallengeStore()),
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
      // 알림 날짜 선택기를 위한 한국어 설정
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
    ));
  }
}
