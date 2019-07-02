import 'package:flutter/material.dart';
import 'package:movs4u/utils/app_constants.dart';
Widget loader(Widget formUi,screenWidth,screenHeight){
  return Container(
    child: Stack(
      children: <Widget>[
        formUi,
        Container(
          decoration: BoxDecoration(
              color: AppConstants.accentColor.withOpacity(0.07)),
          width: screenWidth,
          height: screenHeight,
          alignment: AlignmentDirectional.center,
          child: Center(
            child: SizedBox(
              height: screenWidth/10,
              width: screenWidth/10,
              child: new CircularProgressIndicator(
                value: null,
                strokeWidth: 5.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}