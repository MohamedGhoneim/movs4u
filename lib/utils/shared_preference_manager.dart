import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String sharedIsLogged = 'loggedStatus_AlEslah';
  static bool loggedIn = false;
  static final String sharedUserData = 'userData';
  static String userData;

  /// ------------------------------------------------------------
  /// ------------------------------------------------------------
  ///   Logged Status Methods
  static Future<bool> getLoggedStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool(sharedIsLogged);
    return loggedIn;
  }

  static Future<bool> setLoggedStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(sharedIsLogged, value);
  }

  /// ------------------------------------------------------------
  /// ------------------------------------------------------------
  ///    Language Used Data Methods
  static Future<String> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = prefs.getString(sharedUserData);
    return userData;
  }

  static Future<bool> setUserData(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(sharedUserData, value);
  }

  /// ------------------------------------------------------------
  /// ------------------------------------------------------------
}
