import 'package:flutter/material.dart';
import 'package:movs4u/models/main_category_item_posts_model.dart';
import 'package:movs4u/ui/public_widgets/gradient_container.dart';
import 'package:movs4u/ui/public_widgets/radius_image.dart';
import 'package:movs4u/utils/app_constants.dart';

class FilmDetailsScreen extends StatefulWidget {
  AsyncSnapshot<MainCategoryItemPostsModel> snapshot;
  int position;

  FilmDetailsScreen({this.snapshot, this.position});

  @override
  _FilmDetailsScreenState createState() => _FilmDetailsScreenState();
}

class _FilmDetailsScreenState extends State<FilmDetailsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/main_bg.png"),
              fit: BoxFit.cover,
              alignment: Alignment.center),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
                'مشاهدة ${widget.snapshot.data.postData[widget.position].title} أونلاين '),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            children: <Widget>[
              filmDetails(),
              relatedFilmsTitle(),
              relatedList()
            ],
          ),
        ),
      ),
    );
  }

  Widget filmDetails() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      color: AppConstants.primaryColor,
      width: screenWidth,
      height: screenHeight / 3,
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: radiusImage(
                  '${AppConstants.baseUrl}${widget.snapshot.data.postData[widget.position].image}',
                  screenHeight / 3,
                  20.0),
            ),
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              detailsText(widget.snapshot.data.postData[widget.position].title,
                  FontWeight.bold, Colors.white, AppConstants.fontSize),
              detailsText(
                  widget.snapshot.data.postData[widget.position].categoryName,
                  FontWeight.normal,
                  Colors.white,
                  AppConstants.smallFontSize),
              detailsText(
                  widget.snapshot.data.postData[widget.position].created_at,
                  FontWeight.normal,
                  AppConstants.buttonColor,
                  AppConstants.smallFontSize),
              detailsText(
                  widget.snapshot.data.postData[widget.position].excerpt,
                  FontWeight.normal,
                  Colors.white,
                  AppConstants.smallFontSize),
              SizedBox(
                height: 10.0,
              ),
              watchButton()
            ],
          ))
        ],
      ),
    );
  }

  Widget relatedFilmsTitle() {
    return Container(
      width: screenWidth,
      height: 50.0,
      color: AppConstants.bgColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 15.0,
                  right: 10.0,
                  child: Text(
                    ' ${widget.snapshot.data.postData[widget.position].categoryName}',
                    style: TextStyle(color: AppConstants.buttonColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  right: 20.0,
                  child: Image.asset(
                    'images/hover-icon.png',
                    width: 15.0,
                  ),
                )
              ],
            ),
          ),
          FlatButton(
            splashColor: AppConstants.buttonColorSplash,
            shape: StadiumBorder(),
            onPressed: () {
//                  Navigator.of(context).pushReplacement(
//                      MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'مشاهدة الكل',
                  style: TextStyle(
                    fontSize: AppConstants.smallestFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 7.0,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget relatedList() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: screenWidth / 4,
      height: screenHeight / 3,
      color: AppConstants.bgColor,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.snapshot.data.postData.length,
          itemBuilder: (context, int position) {
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FilmDetailsScreen(
                              snapshot: widget.snapshot,
                              position: position,
                            )));
              },
              child: Container(
                height: screenHeight / 3 ,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(Radius.circular(10.0)),
                    color: AppConstants.fontColor),
                child: Stack(
                  children: <Widget>[
                    /*Container(
                      width: screenWidth / 3,
                      height: screenHeight / 4,*/
                      //child:
                radiusImage(
                          '${AppConstants.baseUrl}${widget.snapshot.data.postData[position].image}',
                          screenHeight / 4,
                          10.0),
                   // ),
              /*      Positioned(
                      bottom: 30.0,
                      child:*/
                      gradientContainer(AppConstants.primaryColor,
                          screenHeight / 4, 10.0),
                  //  ),
                   /* Positioned(
                      bottom: 0.0,
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth / 3,
                        height: 30.0,
                        decoration: BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)),
                            color: AppConstants.fontColor),
                        child: Text(
                          widget.snapshot.data.postData[position].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppConstants.smallFontSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.0),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget detailsText(
      String text, FontWeight fontWeight, Color fontColor, double fontSize) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        maxLines: 2,
        style: TextStyle(
            color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }

  // Create Submit Watch Button
  Widget watchButton() {
    return Container(
      alignment: Alignment.centerRight,
      height: 30.0,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: AppConstants.buttonColor,
        splashColor: AppConstants.buttonColorSplash,
        onPressed: () {},
        child: Container(
          width: screenWidth / 4,
          child: Text(
            'مشاهده',
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
