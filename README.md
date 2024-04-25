# Flutter-shopping-app-1

- 개발환경: AndroidStudio / Firebase
- clone coding
<hr>


![](https://velog.velcdn.com/images/sungwbs/post/a3923b19-f098-403b-90ad-268a7cfb056f/image.png)

<hr>

# SCREENS 하위 폴더
 > - index파일은 기본적으로 index값의 변화에 따른 상태를 업데이트 해주고 있으며, 탭 위젯에 대한 매소드를 정의하였습니다. register, login 스크린에서는 각 modesl에 만들어진 인스턴스를 불러와 매서드를 통해 상태변화를 변경해주는 역할을 하고 있습니다. Splash에서는 앱 전체의 초기 Timer 초기화와 상태변화를 잡아주고 있으며, 인증을 통해 스크린을 지정해주고 있습니다.
 
▶ **screens Folder - index.dart**
```c
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:one/tabs/tab_cart.dart';
import 'package:one/tabs/tab_home.dart';
import 'package:one/tabs/tab_profile.dart';
import 'package:one/tabs/tab_search.dart';


class IndexScreen extends StatefulWidget {

  @override
  _IndexScreenState createState() {
    return _IndexScreenState();
  }
}

class _IndexScreenState extends State<IndexScreen> {

  int _currentIndex = 0;  // 변수 초기화 후, 인덱스 값으로 상호작용

  final List<Widget> tabs = [
    TabHome(),
    TabSearch(),
    TabCart(),
    TabProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 44,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // 해당 인덱스로 업데이트
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}
```

▶ **screens Folder - login.dart**
```c
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one/models/model_auth.dart';
import 'package:one/models/model_login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginModel(),
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              EmailInput(),
              PasswordInput(),
              LoginButton(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Divider(
                  thickness: 1,
                ),
              ),
              RegisterButton(),
            ],
          ),
        ));
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        onChanged: (email) {
          login.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        onChanged: (password) {
          login.setPassword(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          helperText: '',
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    final login = Provider.of<LoginModel>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          await authClient
              .loginWithEmail(login.email, login.password)
              .then((loginStatus) {
            if (loginStatus == AuthStatus.loginSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content:
                    Text('welcome! ' + authClient.user!.email! + ' ')));
              Navigator.pushReplacementNamed(context, '/index');
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('login fail')));
            }
          });
        },
        child: Text('Login'),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/register');
        },
        child: Text(
          'Regist by email',
        ));
  }
}
```

▶ **screens Folder - register.dart**
```c
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one/models/model_auth.dart';
import 'package:one/models/model_register.dart';


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            EmailInput(),
            PasswordInput(),
            PasswordConfirmInput(),
            RegistButton()
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (email) {
          register.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context);
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          register.setPassword(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          helperText: '',
          errorText: register.password != register.passwordConfirm ? 'Password incorrect' : null,
        ),
      ),
    );
  }
}

class PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
        onChanged: (password) {
          register.setPasswordConfirm(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password confirm',
          helperText: '',
        ),
      ),
    );
  }
}

class RegistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    final register = Provider.of<RegisterModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: (register.password != register.passwordConfirm) ? null : () async {
          await authClient
              .registerWithEmail(register.email, register.password)
              .then((registerStatus) {
            if (registerStatus == AuthStatus.registerSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Regist Success')),
                );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Regist Fail')),
                );
            }
          });
        },
        child: Text('Regist'),
      ),
    );
  }
}
```

▶ **screens Folder - Splash.dart**
```c
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin){
      if(isLogin){
        Navigator.of(context).pushReplacementNamed('/index');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }


  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), (){
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: null,
        body: Center(
          child: Text("Splash Screen"),
        )
    );
  }
}
```

<hr>

# TABS 하위 파일
  
> - 각 탭에 대한 정보를 담는 파일입니다. 하지만 아직 테스트 구현중에 있기에 따로 상품을 담지 않고 텍스트로 구현해놓았습니다. 추후에 각 상품들에 정보를 파이어베이스 기능을 통하여 지정 할 예정이며, 검색 및 장바구니에 추가하는 기능 또한 추가 할 예정입니다. 
- 특히 여기서 profile 파일에는 로그인 된 회원이 로그아웃을 할 수 있는 기능을 만들어 놓았기에 버튼 클릭으로 로그아웃과 동시에 초기화면으로 돌아가는 것을 확인 할 수 있습니다.

▶ **tabs Folder - home.dart**
```c
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(" Tab"),
    );
  }
}
```

▶ **tabs Folder - search.dart**
```c
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabSearch extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("search Tab"),
    );
  }
}
```

▶ **tabs Folder - cart.dart**
```c
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabCart extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Cart Tab"),
    );
  }
}
```

▶ **tabs Folder - profile.dart**
```c
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one/models/model_auth.dart';

class TabProfile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cart Profile"),
          LoginOutButton(),
        ],
      ),
    );
  }
}

//계정 로그아웃, StatelessWidget 사용으로 동적으로 움직임.
class LoginOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final   authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    return TextButton(
        onPressed: () async {
          await authClient.logout();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('logout!')));
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: Text('logout'));
  }
}
```
<hr>

1. 로그인 화면
![](https://velog.velcdn.com/images/sungwbs/post/dd93a29b-6169-4224-898e-ae09d8ed0fc3/image.PNG)
2. 회원가입 화면
![](https://velog.velcdn.com/images/sungwbs/post/430ec736-4853-4e65-a578-52171d167174/image.PNG)
3. 기본 홈 화면 + 검색, 장바구니, 프로필 탭 구현
![](https://velog.velcdn.com/images/sungwbs/post/f00daa51-1db4-4fba-9db1-61ac7bf43e52/image.PNG)
4. 프로필 탭 안에서 로그아웃 기능 설정
![](https://velog.velcdn.com/images/sungwbs/post/f1cde1ce-542b-4555-84fc-183c00ff91ec/image.PNG)



