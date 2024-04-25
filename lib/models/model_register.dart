import 'package:flutter/material.dart';

// 회원가입 화면 상태를 관리하는 모델 클래스
class RegisterModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String passwordConfirm = "";

  // 이메일 값을 설정하는 메서드
  void setEmail(String email) {
    this.email = email;  //상위 클래스에 선언 된 변수를 가져옴
    notifyListeners();
  }

  // 비밀번호 값을 설정하는 메서드
  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  // 비밀번호 확인 값을 설정하는 메서드
  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
    notifyListeners();
  }
}