import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movs4u/utils/app_constants.dart';

Widget radiusImage(url, height, imageRadius) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: new BorderRadius.all(
        Radius.circular(imageRadius),
      ),
    ),
    child: ClipRRect(
      borderRadius: new BorderRadius.circular(imageRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fill,
        useOldImageOnUrlChange: true,
        placeholder: (context, url) => Center(
              child: Container(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            ),
        errorWidget: (context, url, error) => Center(
              child: Container(
                width: 40.0,
                height: 40.0,
                child: Icon(Icons.error,color: AppConstants.buttonColor,),
              ),
            ),
      ),
    ),
  );
}
