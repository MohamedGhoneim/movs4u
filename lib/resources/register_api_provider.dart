import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movs4u/utils/app_constants.dart';
import 'package:movs4u/utils/shared_preference_manager.dart';

class RegisterApiProvider {
   register(
      context, scaffoldKey, name, email, mobile, password, deviceToken) async {
    String snackBarMsg = '';
    var user = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "device_token": deviceToken,
    };

    final registerResponse = await http
        .post(
      '${AppConstants.baseUrl}api/register',
      body: user,
    )
        .then((response) {
      var responseBody = json.decode(response.body);
      if (responseBody['status'] == false) {
        print(response.body);
        snackBarMsg = responseBody['error'];
      } else {
        print(responseBody['userinfo']);
        print(response.statusCode);
        SharedPreferenceManager.setLoggedStatus(true);
        String userData = json.encode(responseBody['userinfo']);
        SharedPreferenceManager.setUserData(null);
        SharedPreferenceManager.setUserData(userData);
        AppConstants.loggedStatus = true;

        snackBarMsg = 'تم التسجيل بنجاح';
        Navigator.pushReplacementNamed(context, '/HomeScreen');
      }

      SnackBar snackBar = new SnackBar(content: new Text(snackBarMsg));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }).catchError((error) {
      print(error);
      snackBarMsg = error.toString();
      SnackBar snackBar = new SnackBar(content: new Text(snackBarMsg));
      scaffoldKey.currentState.showSnackBar(snackBar);
    });
  }
}
