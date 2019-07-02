import 'package:movs4u/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movs4u/ui/screens/home_screen.dart';
import 'package:movs4u/ui/screens/login_screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bahij',
      ),
      //===========================================
      onGenerateTitle: (BuildContext context) => 'مسلسلات',

      routes: <String, WidgetBuilder>{
        '/LoginScreen': (BuildContext context) => new LoginScreen(),
        '/HomeScreen': (BuildContext context) => new HomeScreen(),
      },
      home: SplashScreen(),
    );
  }
}

