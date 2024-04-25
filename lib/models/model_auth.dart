import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 인증 상태를 나타내는 열거형
enum AuthStatus {
  registerSuccess, //회원가입 성공
  registerFail,
  loginSuccess,  //로그인 성공
  loginFail
}

// FirebaseAuth 인증을 제공하는 클래스 // ChangeNotifier 상태 변경을 알리는 클래스
class FirebaseAuthProvider with ChangeNotifier {
  FirebaseAuth authClient; // authClient 객체를 통해 다양한 사용자 인증 관련 메서드를 호출할 수 있습니다.
  User? user;  // user 변수는 값을 가질 수도 있고, null일 수도 있습니다.

  FirebaseAuthProvider({auth}) : authClient = auth ??  //인스턴스 초기화
      FirebaseAuth.instance; // 삼항연산자 사용. null이 아닌 경우에는 그 값을 사용하고, null인 경우에는 FirebaseAuth 클래스의 기본 인스턴스를 사용

  // 이메일로 로그인하는 메서드  // 25-이메일과 비밀번호를 사용하여 새 사용자를 등록합니다.
  Future<AuthStatus> registerWithEmail(String email, String password) async {
    try {
      UserCredential credential = await
      authClient.createUserWithEmailAndPassword(email: email, password: password);
      return AuthStatus.registerSuccess;
    } catch (e) {
      return AuthStatus.registerFail;
    }
  }
  // 34-등록된 사용자로 로그인합니다.
  Future<AuthStatus> loginWithEmail(String email, String password) async {
    try {
      await authClient.signInWithEmailAndPassword(email: email, password: password).then(
              (credential) async {
            user = credential.user;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLogin', true);
            prefs.setString('email', email);
            prefs.setString('password', password);
          }
      );
      return AuthStatus.loginSuccess;
    } catch (e) {
      return AuthStatus.loginFail;
    }
  }

  // 로그아웃하는 메서드 // 56-현재 로그인된 사용자를 로그아웃합니다.
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('email', '');
    prefs.setString('password', '');
    user = null;
    await authClient.signOut();
  }
}
