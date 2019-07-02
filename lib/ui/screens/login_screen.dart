import 'package:flutter/material.dart';
import 'package:movs4u/blocs/login_bloc.dart';
import 'package:movs4u/ui/repeated_fields_widgets/email_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/password_field.dart';
import 'package:movs4u/ui/repeated_fields_widgets/skip_button.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'package:movs4u/ui/screens/register_screen.dart';
import 'package:movs4u/ui/screens/reset_password_screen.dart';
import 'package:movs4u/ui/public_widgets/loader.dart';

class LoginScreen extends StatefulWidget {
static _LoginScreenState of(BuildContext context) =>
context.ancestorStateOfType(const TypeMatcher<_LoginScreenState>());
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _screenWidth;
  double _screenHeight;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String _deviceToken = '123456789';
  final _bloc = LoginBloc();
  bool isLoading = false;
/*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }*/

  @override
  void initState() {
    // TODO: implement initState
    _emailController.addListener(() {
      //use setState to rebuild the widget
    });
    super.initState();
  }
  loadingState() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        if (isLoading) {
          setState(() {
            isLoading = false;
          });
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: scaffoldKey,
          body: Container(
              height: _screenHeight,
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage("images/main_bg.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
              ),
              child: isLoading
                  //? LoadingScreen(formUi: loginScreenUi(_bloc))
                  ? loader(loginScreenUi(_bloc), _screenWidth, _screenHeight)
                  : loginScreenUi(_bloc)),
        ),
      ),
    );
  }

  Widget loginScreenUi(LoginBloc bloc) {
    return ListView(
      children: <Widget>[
        Center(
            child: Image.asset("images/logo_register.png",
                width: _screenWidth / 2, height: _screenWidth / 2)),
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
                  emailField(bloc, 'admin@domain.com', 'البريد الالكتروني',
                      _emailController),
                  SizedBox(height: 10.0),
                  passwordField(
                      bloc, '********', 'كلمة المرور', _passwordController),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(child: resetPasswordButton()),
                      Expanded(child: registerButton())
                    ],
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
  Widget submitButton(LoginBloc bloc) {
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
                    bloc.submit(context,scaffoldKey, _deviceToken,(){loadingState();});
                    //Pass teh function of some class to another class as shown to use it in on tap or directly
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
                    /*Future.delayed(const Duration(seconds: 5), () {
                      setState(() {
                        // Here you can write your code for open new view
                        isLoading = false;
                      });
                    });*/
                  });
                },
                child: Container(
                  width: _screenWidth / 3,
                  child: Text(
                    'دخـــول',
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

  // Create Reset Password Button
  Widget resetPasswordButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ResetPasswordScreen()));
      },
      splashColor: AppConstants.buttonColorSplash,
      shape: StadiumBorder(),
      child: Text(
        'هل نسيت كلمة المرور؟',
        style: TextStyle(
          fontSize: AppConstants.smallFontSize,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // Create Register Button
  Widget registerButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => RegisterScreen()));
      },
      splashColor: AppConstants.buttonColorSplash,
      shape: StadiumBorder(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.person, color: Colors.white, size: 18.0),
          SizedBox(width: 5.0),
          Text(
            'تسجيل حساب جديد',
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
