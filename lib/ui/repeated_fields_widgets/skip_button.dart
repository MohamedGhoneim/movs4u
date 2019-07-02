import 'package:flutter/material.dart';
import 'package:movs4u/ui/screens/home_screen.dart';
import 'package:movs4u/utils/app_constants.dart';

// Create Skip Button
Widget skipButton(BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
    child: FlatButton(
      splashColor: AppConstants.buttonColorSplash,
      shape: StadiumBorder(),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'تخطـي',
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              color: AppConstants.buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5.0),
          Icon(
            Icons.arrow_back,
            color: AppConstants.buttonColor,
            size: AppConstants.smallFontSize,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    ),
  );
}
