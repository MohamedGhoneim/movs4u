import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'package:movs4u/models/user_model.dart';
import 'package:movs4u/utils/shared_preference_manager.dart';
import 'package:http/http.dart' as http;

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  double screenWidth;
  double screenHeight;
  String name = 'admin admin';
  String email = 'admin@admin.com';
  String mobile = '0123456789';
  String password = '********';
  String subscription = 'غير مدفوع';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String data = '';
  String type = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  loadingStatus() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (AppConstants.loggedStatus) {
      UserModel userModel =
          UserModel.fromJson(json.decode(AppConstants.userData));
      name = userModel.name;
      email = userModel.email;
      mobile = userModel.mobile;
    }
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight / 3,
              child: Stack(children: <Widget>[
                Image.asset(
                  'images/profile-bg.png',
                  width: screenWidth,
                  height: screenHeight / 3,
                  fit: BoxFit.fill,
                ),
                Container(
                  child: Positioned(
                    right: screenWidth / 4 + 20.0,
                    bottom: 50.0,
                    child: Text(
                      'الصفحة الشخصية',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConstants.bigTitleFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              height: screenHeight / 2,
              child: ListView(
                children: <Widget>[
                  globalText(context, scaffoldKey, 'الاسم بالكامل', name,
                      nameController, false, 'name'),
                  globalText(context, scaffoldKey, 'البريد الإلكتروني', email,
                      emailController, true, 'email'),
                  globalText(context, scaffoldKey, 'جوال', mobile,
                      mobileController, false, 'mobile'),
                  globalText(context, scaffoldKey, 'كلمة المرور', password,
                      passwordController, true, 'password'),
                  globalText(context, scaffoldKey, 'حالة الإشتراك',
                      subscription, null, false, 'subscribtion'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Create GlobalText
  Widget globalText(context, scaffoldKey, String title, String text,
      TextEditingController controller, bool hasBg, String type) {
    return Container(
      color: hasBg ? Colors.grey[200] : Colors.white,
      margin: EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: title,
                    style: TextStyle(
                        fontSize: AppConstants.fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryColor,
                        fontFamily: 'Bahij')),
                TextSpan(
                  text: '  |  $text',
                  style: TextStyle(
                      fontSize: AppConstants.fontSize,
                      color: text == 'غير مدفوع'
                          ? Colors.red
                          : AppConstants.fontColor,
                      fontFamily: 'Bahij'),
                )
              ]),
            ),
          ),
          type == 'subscribtion'
              ? Container(
                  height: 30.0,
                  width: 80.0,
                  child: text == 'غير مدفوع'
                      ? FlatButton(
                          splashColor: AppConstants.buttonColorSplash,
                          shape: StadiumBorder(),
                          color: Colors.grey,
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_circle,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'إدفع',
                                style: TextStyle(
                                    fontSize: AppConstants.fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ))
                      : SizedBox(),
                )
              : Container(
                  width: 50.0,
                  child: FlatButton(
                      splashColor: AppConstants.buttonColorSplash,
                      shape: StadiumBorder(),
                      onPressed: () {
                        switch (type) {
                          case 'name':
                            editFieldBottomSheet(
                                context,
                                scaffoldKey,
                                title,
                                text,
                                controller,
                                TextInputType.text,
                                type,
                                Icons.person);
                            type = 'name';
                            break;
                          case 'email':
                            editFieldBottomSheet(
                                context,
                                scaffoldKey,
                                title,
                                text,
                                controller,
                                TextInputType.emailAddress,
                                type,
                                Icons.email);
                            type = 'email';
                            break;
                          case 'mobile':
                            editFieldBottomSheet(
                                context,
                                scaffoldKey,
                                title,
                                text,
                                controller,
                                TextInputType.phone,
                                type,
                                Icons.mobile_screen_share);
                            type = 'mobile';
                            break;
                          case 'password':
                            editFieldBottomSheet(
                                context,
                                scaffoldKey,
                                '*********',
                                'كلمة المرور القديمة',
                                controller,
                                TextInputType.text,
                                type,
                                Icons.lock);
                            type = 'password';
                            break;
                        }
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppConstants.accentColor,
                        size: 15.0,
                      )),
                ),
        ],
      ),
    );
  }

  editFieldBottomSheet(
      BuildContext context,
      scaffoldKey,
      String hint,
      String label,
      TextEditingController controller,
      TextInputType keyboardType,
      String apiVariable,
      IconData icon) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20.0),
            // alignment: Alignment.bottomCenter,
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceOut,
              child: ListView(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  requiredField(hint, label, controller, TextInputType.text,
                      icon, apiVariable),
                  apiVariable == 'password'
                      ? SizedBox(
                          height: 10.0,
                        )
                      : SizedBox(
                          height: 10.0,
                        ),
                  apiVariable == 'password'
                      ? requiredField(hint, 'كلمة المرور الجديدة', controller,
                          TextInputType.text, Icons.lock, apiVariable)
                      : SizedBox(
                          height: 10.0,
                        ),
                  submitButton(
                      context, scaffoldKey, apiVariable, controller.text),
                ],
              ),
            ),
          );
        });
  }

// Create Optional TextField
  Widget requiredField(
      String hint,
      String label,
      TextEditingController controller,
      TextInputType keyboardType,
      IconData icon,
      String type) {
    return Form(
      key: formKey,
      autovalidate: autoValidate,
      child: TextFormField(
        controller: controller,
        autofocus: true,
        keyboardType: keyboardType,
        validator: type == 'email' ? validateEmail : validateName,
        onSaved: (String val) {
          data = val;
        },
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: new BorderSide(
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black87, size: 25.0),
          contentPadding: EdgeInsets.all(5.0),
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'أدخل البيانات بصورة صحيحه';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'بريد الكتروني خاطئ';
    else
      return null;
  }

  submitButton(
      BuildContext context, scaffoldKey, String apiVariable, String data) {
    double screenWidth = MediaQuery.of(context).size.width;
    return RaisedButton(
      shape: StadiumBorder(),
      color: AppConstants.buttonColor,
      splashColor: AppConstants.buttonColorSplash,
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          updateProfile(context, scaffoldKey, apiVariable, data);
        } else {
//    If all data are not valid then start auto validation.
          setState(() {
            autoValidate = true;
          });
        }
      },
      child: Container(
        width: screenWidth / 3,
        child: isLoading
            ? Container(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              )
            : Text(
                'تحديث',
                style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  updateProfile(context, scaffoldKey, String variable, String data) async {
    loadingStatus();
    String snackBarMsg = '';
    var user = {
      variable: data,
    };

    UserModel userModel = UserModel.fromJson(jsonDecode(AppConstants.userData));
    print('user : $user  token : ${userModel.accessToken}');
    final updateProfileResponse = await http
        .post(
      '${AppConstants.baseUrl}/api/update-profile',
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${userModel.accessToken}'},
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
        AppConstants.userData = userData;

        AppConstants.loggedStatus = true;
        setState(() {
          UserModel userModel =
              UserModel.fromJson(json.decode(AppConstants.userData));
          name = userModel.name;
          email = userModel.email;
          mobile = userModel.mobile;
        });
        snackBarMsg = 'تم التحديث بنجاح';
      }
      loadingStatus();

      SnackBar snackBar = new SnackBar(content: new Text(snackBarMsg));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }).catchError((error) {
      loadingStatus();

      print(error);
      snackBarMsg = error.toString();
      SnackBar snackBar = new SnackBar(content: new Text(snackBarMsg));
      scaffoldKey.currentState.showSnackBar(snackBar);
    });
  }
}
