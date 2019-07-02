import 'package:flutter/material.dart';
import 'package:movs4u/ui/screens/biography_screen.dart';
import 'package:movs4u/ui/screens/home_screen.dart';
import 'package:movs4u/ui/screens/login_screen.dart';
import 'dart:async';
import 'package:movs4u/utils/shared_preference_manager.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'package:movs4u/ui/public_widgets/fade_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getSettings();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        if (AppConstants.loggedStatus == true) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => BiographyScreen()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: screenWidth,
          child: Image(
            image: AssetImage('images/splash.gif'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

getSettings() {
  SharedPreferenceManager.getLoggedStatus().then((value) {
    if (value != null) {
      AppConstants.loggedStatus = value;
    } else {
      AppConstants.loggedStatus = false;
    }
  });
  SharedPreferenceManager.getUserData().then((value) {
    if (value != null) {
      AppConstants.userData = value;
    } else {
      AppConstants.userData = '';
    }
  });
}
