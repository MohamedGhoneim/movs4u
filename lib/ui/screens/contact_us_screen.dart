import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movs4u/models/user_model.dart';
import 'package:movs4u/utils/app_constants.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  double screenWidth;
  double screenHeight;
  bool isLoading = false;

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
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight / 2,
              child: Stack(children: <Widget>[
                Image.asset(
                  'images/biography1.png',
                  width: screenWidth,
                  height: screenHeight / 2,
                  fit: BoxFit.fill,
                ),
                Container(
                  //width: screenWidth / 4 ,height: screenWidth / 4 ,

                  child: Positioned(
                    right: 20.0,
                    bottom: 0.0,
                    child: Container(
                      width: screenWidth / 6,
                      height: screenWidth / 6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenWidth / 6),
                          ),
                          color: AppConstants.buttonColor),
                      child: Text(
                        'مساعدة',
                        style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontSize: AppConstants.smallTitleFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -20.0,
                  child: FlatButton(
                    splashColor: AppConstants.buttonColorSplash,
                    shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color:Colors.white,
                      size: AppConstants.smallTitleFontSize,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              height: screenHeight / 2,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  globalText('+96663256326325', Icons.phone),
                  globalText('info@movs4u.com', Icons.email),
                  globalText('شارع الملك عبد الله، الرياض، السعودية',
                      Icons.location_on),
                  globalText('+96663256326325', Icons.print),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Create GlobalText
  Widget globalText(String text, IconData icon) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: AppConstants.fontSize,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                  fontFamily: 'Bahij'),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: AppConstants.primaryColor),
            child: Icon(
              icon,
              color: AppConstants.buttonColor,
              size: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
