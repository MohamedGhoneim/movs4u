import 'package:flutter/material.dart';

Widget gradientContainer(gradientColor,height, gradientRadius) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: new BorderRadius.all(
        Radius.circular(gradientRadius),
      ),
      gradient: new LinearGradient(
          colors: [gradientColor.withOpacity(0.3), gradientColor],
          begin: FractionalOffset.center,
          end: FractionalOffset.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),
  );
}
