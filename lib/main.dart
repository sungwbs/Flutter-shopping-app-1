import 'package:flutter/material.dart';
import 'screens/screen_index.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_login.dart';
import 'screens/screen_register.dart';
import 'package:provider/provider.dart';
import 'package:one/firebase_options.dart';
import 'package:one/models/model_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>
            FirebaseAuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Shopping mall',
        routes: {
          '/index': (context) => IndexScreen(),
          '/login': (context) => LoginScreen(),
          '/splash': (context) => SplashScreen(),
          '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}