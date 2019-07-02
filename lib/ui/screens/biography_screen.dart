import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movs4u/utils/app_constants.dart';

import 'package:movs4u/ui/screens/login_screen.dart';
import 'package:movs4u/ui/public_widgets/fade_animation_widget.dart';

class BiographyScreen extends StatefulWidget {
  @override
  _BiographyScreenState createState() => _BiographyScreenState();
}

class _BiographyScreenState extends State<BiographyScreen>
    {
  List biographyImagesList = [
    'images/biography1.png',
    'images/biography1.png',
    'images/biography1.png'
  ];
  List biographyTitlesList = [
    'نبذة تعريفية عن التطبيق وكيفية استخدامه!',
    'أهم مميزات التطبيق ومايميزه عن غيره!',
    'كيف يمكن أن تربح من التطبيق؟'
  ];

  List biographyDetailsList = [
    'التطبيق عبارة عن تطبيق افلام ومسلسلات يعرض احدث واجدد الافلام والمسلسلات الحصرية التطبيق عبارة عن تطبيق افلام ومسلسلات يعرض احدث واجدد الافلام والمسلسلات الحصرية التطبيق عبارة عن تطبيق افلام ومسلسلات يعرض احدث واجدد الافلام والمسلسلات الحصرية التطبيق عبارة عن تطبيق افلام ومسلسلات يعرض احدث واجدد الافلام والمسلسلات الحصرية ',
    'يتميز التطبيق عن غيره في سهولة استخدامه يتميز التطبيق عن غيره في سهولة استخدامه يتميز التطبيق عن غيره في سهولة استخدامه',
    'تستطيع التربح من التطبيق من خلال تستطيع التربح من التطبيق من خلال تستطيع التربح من التطبيق من خلال تستطيع التربح من التطبيق من خلال'
  ];

  double screenWidth;
  double screenHeight;
  int selectedIndex = 0;

  final controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            swiperViewPager(selectedIndex),
            SizedBox(height: 20.0),
            // selectedIndex == 2 ?
            nextButton()
            //: SizedBox()
          ],
        ),
      ),
    );
  }

// Create Image View Pager With Dotted Indicator Using Swiper
  Widget swiperViewPager(int index) {
    return Container(
      height: screenHeight / 4 * 3,
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black26,
          canvasColor: Colors.black,
        ),
        child: Swiper(
          onIndexChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int position) {
            return Column(
              children: <Widget>[
                Image.asset(
                  biographyImagesList[position],
                  width: screenWidth,
                  height: screenHeight / 2,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 10.0),
                Text(
                  biographyTitlesList[position],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.fontSize,
                      color: AppConstants.fontColorDark),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    biographyDetailsList[position],
                    style: TextStyle(
                        fontSize: AppConstants.smallFontSize,
                        color: AppConstants.fontColor),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          },
          itemCount: 3,
          loop: false,
          pagination: new SwiperPagination(),
          autoplay: false,
          controller: controller,
          index: index,
        ),
      ),
    );
  }

  // Create Next Button
  Widget nextButton() {
    return Center(
      child: RaisedButton(
        shape: StadiumBorder(),
        color: AppConstants.buttonColor,
        splashColor: AppConstants.buttonColorSplash,
        onPressed: () {
          if (selectedIndex == 2) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
          } else {
            setState(() {
              controller.next();
            });
          }
        },
        child: Container(
          width: screenWidth / 3,
          child: Text(
            selectedIndex == 2 ? 'إبدء الآن' : 'التالي',
            style: TextStyle(
              fontSize: AppConstants.fontSize,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
