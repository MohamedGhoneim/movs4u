import 'dart:async';
import 'package:movs4u/resources/register_api_provider.dart';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Object with Validators implements BaseBloc {
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  Function(String) get nameChanged => _nameController.sink.add;

  Function(String) get emailChanged => _emailController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  Function(String) get confirmPasswordChanged =>
      _confirmPasswordController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get name => _nameController.stream.transform(nameValidator);

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<String> get confirmPassword =>
      _confirmPasswordController.stream.transform(confirmPasswordValidator);

  Stream<bool> get submitCheck => Observable.combineLatest4(
      name, email, password, confirmPassword, (n, e, p, c) => true);

  submit(context, scaffoldKey, mobile, deviceToken) {
    final validName = _nameController.value;
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    RegisterApiProvider registerApiProvider= new RegisterApiProvider();
    registerApiProvider.register(context, scaffoldKey, validName, validEmail, mobile, validPassword, deviceToken);
  }

  @override
  void dispose() {
    _nameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _confirmPasswordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
