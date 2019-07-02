import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movs4u/ui/screens/login_screen.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'package:movs4u/utils/shared_preference_manager.dart';

class LoginApiProvider {
  login(BuildContext context, scaffoldKey, email, password, deviceToken,Function fx) async {
    String snackBarMsg = '';
    var user = {
      "email": email,
      "password": password,
      "deviceToken": deviceToken
    };
    final loginResponse = await http
        .post(
      '${AppConstants.baseUrl}api/login',
      body: user,
    )
        .then((response) {
      var responseBody = json.decode(response.body);
      if (responseBody['status'] == false) {
        print(response.body);
        snackBarMsg = responseBody['error'];
        fx(); //If It was some functions ontap use fx; else fx();
        //LoginScreen.of(context).loadingState();

      } else {
        print(responseBody['userinfo']);
        print(response.statusCode);
        SharedPreferenceManager.setLoggedStatus(true);
        String userData = json.encode(responseBody['userinfo']);
        SharedPreferenceManager.setUserData(null);
        SharedPreferenceManager.setUserData(userData);
        AppConstants.loggedStatus = true;
        AppConstants.userData = userData;
        snackBarMsg = 'تم التسجيل بنجاح';
        fx(); //If It was some functions ontap use fx; else fx();
        //LoginScreen.of(context).loadingState();
        Navigator.pushReplacementNamed(context, '/HomeScreen');
      }

      SnackBar snackBar = new SnackBar(content: new Text(snackBarMsg));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }).catchError((error) {
      print(error);
     // LoginScreen.of(context).loadingState();
      snackBarMsg = error.toString();
      SnackBar snackBar = new SnackBar(content: new Text(snackBarMsg));
      scaffoldKey.currentState.showSnackBar(snackBar);
    });
  }
}
