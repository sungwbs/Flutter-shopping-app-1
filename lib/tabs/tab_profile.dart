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