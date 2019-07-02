import 'dart:async';
import 'package:movs4u/resources/login_api_provider.dart';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with Validators implements BaseBloc {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  bool loading = false;
  Function(String) get emailChanged => _emailController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitCheck =>
      Observable.combineLatest2(email, password, (e, p) => true);

  submit(context, scaffoldKey,deviceToken){
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    LoginApiProvider loginApiProvider = LoginApiProvider();
    loginApiProvider.login(
        context, scaffoldKey, validEmail, validPassword, deviceToken);
  }

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
