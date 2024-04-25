import 'package:flutter/material.dart';

 // 로그인 화면 상태를 관리하는 모델 클래스
class LoginModel extends ChangeNotifier {
  String email = "";
  String password = "";

  // 이메일 값을 설정하는 메서드
  void setEmail(String email) {
    this.email = email; // 계속 만들어지는 현재 객체를 지칭
    notifyListeners();  //리스너 알림
  }

  // 비밀번호 값을 설정하는 메서드
  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}