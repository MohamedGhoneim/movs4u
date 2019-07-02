import 'dart:async';

mixin Validators {
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 2) {
      sink.add(name);
    } else {
      sink.addError('اسم المستخدم لايجب ان يقل عن 3 احرف');
    }
  });
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailRegEx = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (emailRegEx.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('بريد الكتروني خاطئ');
    }
  });
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('كلمة المرور لايجب ان تقل عن 8 احرف');
    }
  });
  var confirmPasswordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('تأكيد كلمة المرور لايجب ان تقل عن 8 احرف');
    }
  });
}
