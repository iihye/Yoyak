import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  static String yoyakUrl = dotenv.get('Yoyak_URL');
  static String yoyakToken = dotenv.get('access_token');
}