import 'package:flutter/material.dart';
import 'package:movs4u/ui/screens/about_screen.dart';
import 'package:movs4u/ui/screens/contact_us_screen.dart';
import 'package:movs4u/ui/screens/home_screen.dart';
import 'package:movs4u/utils/app_constants.dart';

// Create Skip Button
Widget sideMenuButton(BuildContext context, String title, IconData icon, String type) {
  return Container(
    child: FlatButton(
      splashColor: AppConstants.buttonColorSplash,
      shape: StadiumBorder(),
      onPressed: () {
        switch(type){
          case 'contactUs':
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactUsScreen(),
              ),
            );
            break;
          case 'about':
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutScreen(),
              ),
            );
            break;

        }

      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppConstants.smallTitleFontSize,
                color: AppConstants.buttonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 5.0),
          Icon(icon,
            color: AppConstants.buttonColor,
            size: AppConstants.bigTitleFontSize,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    ),
  );
}
