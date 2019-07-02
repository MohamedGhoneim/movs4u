import 'package:flutter/material.dart';
import 'package:movs4u/blocs/register_bloc.dart';
import 'package:movs4u/ui/public_widgets/loader.dart';
import 'package:movs4u/ui/repeated_fields_widgets/confirm_password_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/email_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/name_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/optional_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/password_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/skip_button.dart';
import 'package:movs4u/utils/app_constants.dart';

import 'package:movs4u/ui/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double _screenWidth;
  double _screenHeight;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _deviceToken = '123456789';
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = RegisterBloc();
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
            height: _screenHeight,
            padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage("images/main_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: isLoading
                ? loader(registerScreenUi(bloc), _screenWidth, _screenHeight)
                : registerScreenUi(bloc)),
      ),
    );
  }

  Widget registerScreenUi(RegisterBloc bloc) {
    return ListView(
      children: <Widget>[
        Center(
            child: Image.asset("images/logo_register.png",
                width: _screenWidth / 4, height: _screenWidth / 4)),
        SizedBox(height: 50.0),
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: AppConstants.accentColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 20.0)
                  ]),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  nameField(bloc, 'محمد محمد', 'اسم المستخدم', _nameController),
                  SizedBox(height: 10.0),
                  emailField(bloc, 'admin@domain.com', 'البريد الالكتروني',
                      _emailController),
                  SizedBox(height: 10.0),
                  optionalField('0123456789', 'الجوال', _mobileController,
                      TextInputType.number, Icons.mobile_screen_share),
                  SizedBox(height: 10.0),
                  passwordField(
                      bloc, '********', 'كلمة المرور', _passwordController),
                  SizedBox(height: 10.0),
                  confirmPasswordField(bloc, '********', 'تأكيد كلمة المرور',
                      _confirmPasswordController),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[Expanded(child: loginButton())],
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              left: 0.0,
              bottom: -20.0,
              child: Center(child: submitButton(bloc)),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        skipButton(context),
      ],
    );
  }

  // Create Submit Login Button
  Widget submitButton(RegisterBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.submitCheck,
        builder: (blocContext, snapshot) => Center(
              child: RaisedButton(
                shape: StadiumBorder(),
                color: AppConstants.buttonColor,
                splashColor: AppConstants.buttonColorSplash,
                onPressed: () {
                  if (snapshot.hasData) {
                    print('user Data : ${snapshot.data.toString()}');
                    bloc.submit(context, _scaffoldKey, _mobileController.text,
                        _deviceToken);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    );
                  }
                  setState(() {
                    isLoading = true;
                    Future.delayed(const Duration(seconds: 5), () {
                      setState(() {
                        // Here you can write your code for open new view
                        isLoading = false;
                      });
                    });
                  });
                },
                child: Container(
                  width: _screenWidth / 3,
                  child: Text(
                    'تسجيـل',
                    style: TextStyle(
                      fontSize: AppConstants.fontSize,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ));
  }

  // Create Register Button
  Widget loginButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      },
      splashColor: AppConstants.buttonColorSplash,
      shape: StadiumBorder(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.person, color: Colors.white, size: 18.0),
          SizedBox(width: 5.0),
          Text(
            'مسجل بالفعل',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: AppConstants.smallFontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
