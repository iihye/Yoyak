import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yoyak/screen/Login/social_login.dart';

// 뷰 모델
class KakaoViewModel {
  final SocialLogin _socialLogin; // 로그인 or 로그아웃
  bool isLogined = false; // 로그인 여부
  User? user; // 유저

  // 구글, 애플 등 로그인도 쓸 수 있으니까 생성자의 매개변수로 추상 클래스를 넣어줌
  KakaoViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print(user);
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}