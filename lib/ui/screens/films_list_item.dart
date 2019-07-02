import 'package:flutter/material.dart';
import 'package:movs4u/models/main_category_item_posts_model.dart';
import 'package:movs4u/ui/public_widgets/radius_image.dart';
import 'package:movs4u/ui/public_widgets/gradient_container.dart';
import 'package:movs4u/utils/app_constants.dart';

import 'flim_details_screen.dart';

Widget filmListItem(AsyncSnapshot<MainCategoryItemPostsModel> snapshot, height,
    position, radius, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FilmDetailsScreen(
                    snapshot: snapshot,position: position,
                  )));
    },
    child: Container(
      height: 150.0,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            children: <Widget>[
              radiusImage(
                  '${AppConstants.baseUrl}${snapshot.data.postData[position].image}',
                  110.0,
                  radius),
              gradientContainer(AppConstants.primaryColor, 110.0, radius),
              Positioned(
                bottom: 10.0,
                right: 10.0,
                child: Text(
                  snapshot.data.postData[position].created_at,
                  style: TextStyle(
                      color: AppConstants.buttonColor,
                      fontSize: AppConstants.smallestFontSize),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              snapshot.data.postData[position].title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: AppConstants.smallFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0),
            ),
          ),
          Text(
            snapshot.data.postData[position].excerpt,
            style: TextStyle(
                color: Colors.white,
                fontSize: AppConstants.smallestFontSize,
                letterSpacing: 2.0),
            maxLines: 2,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    ),
  );
}
