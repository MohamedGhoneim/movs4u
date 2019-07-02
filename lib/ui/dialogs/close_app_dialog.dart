import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

closeAppDialog(
    BuildContext context,
    String title,
    Color titleColor,
    String desc,
    AlertType alertType,
    String btnOkText,
    String btnNoText,
    String dialogType) {
  // Reusable alert style
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: true,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 1200),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
  Alert(
    style: alertStyle,
    context: context,
    type: alertType,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text(
          btnNoText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient:
        LinearGradient(colors: [Color(0xff666666), Color(0xff666666)]),
      ),
      DialogButton(
        child: Text(
          btnOkText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          switch(dialogType){
            case 'close':
              exit(0);
              break;
          }
        },
        gradient: LinearGradient(colors: [
          AppConstants.primaryColor,
          AppConstants.primaryColor
          //Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      ),
    ],
  ).show();
}
