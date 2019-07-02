
import 'package:flutter/material.dart';
import 'package:movs4u/ui/dialogs/close_app_dialog.dart';
import 'package:movs4u/ui/home_screen_bottom_bar_widgets/films_widget.dart';
import 'package:movs4u/ui/home_screen_bottom_bar_widgets/mosalsalat_widget.dart';
import 'package:movs4u/ui/home_screen_bottom_bar_widgets/profile_widget.dart';
import 'package:movs4u/ui/home_screen_bottom_bar_widgets/search_widget.dart';
import 'package:movs4u/ui/repeated_fields_widgets/side_menu_button.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProfile = false;

  // Bottom Navigation Bar Item Index
  int currentIndex = 0;
  String title = 'أفلام حصرية';

  // Bottom Navigation Bar Widgets List
  static List<Widget> children = [
    FilmsWidget(),
    MosalsalatWidget(),
    SearchWidget(),
    ProfileWidget(),
  ];

  // Bottom Navigation Bar Item Tapped Method
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      switch (index) {
        case 0:
          title = 'أفلام حصرية';
          isProfile = false;
          break;
        case 1:
          title = 'مسلسلات حصرية';
          isProfile = false;
          break;
        case 2:
          title = 'بحث';
          isProfile = false;
          break;
        case 3:
          title = 'صفحتي';
          isProfile = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (currentIndex == 0) {
            closeAppDialog(
                context,
                'إغلاق التطبيق',
                Colors.red,
                'هل تريد إغلاق التطبيق؟',
                AlertType.warning,
                'نعم',
                'إلغاء',
                'close');
          } else {
            setState(() {
              currentIndex = 0;
            });
          }
        },
        child: Directionality(
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
                appBar: !isProfile
                    ? AppBar(
                        title: Text(title),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )
                    : null,
                drawer: drawer(),
                body: children[currentIndex],
                bottomNavigationBar: loggedCustomBottomNavigationBar()),
          ),
        ));
  }

  Widget drawer() {
    return Drawer(
        child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/main_bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center),
      ),
      child: ListView(
        children: <Widget>[
          Image.asset(
            'images/logo_register.png',
            height: 100.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          sideMenuButton(
              context, 'تواصل معنا', Icons.contact_phone, 'contactUs'),
          sideMenuButton(context, 'حـــــول', Icons.note, 'about'),
        ],
      ),
    ));
  }

  // Create Logged User Custom Bottom Navigation Bar
  Widget loggedCustomBottomNavigationBar() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: AppConstants.buttonColor,
          unselectedItemColor: AppConstants.accentColor,
          onTap: onTabTapped,
          // new
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            customBottomNavigationBarItem(
                Icon(
                  Icons.local_movies,
                  size: 40.0,
                ),
                'أفلام'),
            customBottomNavigationBarItem(
                Icon(
                  Icons.tv,
                  size: 40.0,
                ),
                'مسلسلات'),
            customBottomNavigationBarItem(
                Icon(
                  Icons.search,
                  size: 40.0,
                ),
                'البحث'),
            customBottomNavigationBarItem(
                Icon(
                  Icons.person,
                  size: 40.0,
                ),
                'صفحتك'),
          ]),
    );
  }

  // Create Custom Bottom Navigation Bar Item
  BottomNavigationBarItem customBottomNavigationBarItem(
      Icon icon, String title) {
    return BottomNavigationBarItem(
      icon: icon,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: AppConstants.fontSize),
      ),
    );
  }
}
