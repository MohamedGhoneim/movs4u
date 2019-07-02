import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movs4u/utils/app_constants.dart';
import 'package:movs4u/utils/shared_preference_manager.dart';

class ResetPasswordApiProvider {
  Future<http.Response> resetPassword(context,scaffoldKey,email, password, deviceToken) async {
    String snackBarMsg = '';
    var user = {
      "email": email,
      "password": password,
      "device_token": deviceToken,
    };

    final resetPasswordResponse = await http
        .post('${AppConstants.baseUrl}api/login',
      body: user,
    )
        .then((response) {
      var responseBody = json.decode(response.body);
      if (responseBody['status'] == false) {
        print(response.body);
        snackBarMsg = responseBody['message'];

      } else {
          print(responseBody['user']);
          print(response.statusCode);
          SharedPreferenceManager.setLoggedStatus(true)
              .then((bool commited) {});
          String userData = json.encode(responseBody['user']);
          SharedPreferenceManager.setUserData(null);
          SharedPreferenceManager.setUserData(userData);

        snackBarMsg = 'تم تسجيل الدخول بنجاح';
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

    return resetPasswordResponse;
  }
}
