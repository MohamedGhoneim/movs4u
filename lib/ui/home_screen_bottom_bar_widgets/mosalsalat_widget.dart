import 'package:flutter/material.dart';
import 'package:movs4u/blocs/main_category_bloc.dart';
import 'package:movs4u/blocs/main_category_posts_bloc.dart';
import 'package:movs4u/models/main_category_item_model.dart';
import 'package:movs4u/models/main_category_item_posts_model.dart';
import 'package:movs4u/ui/public_widgets/sliver_app_bar_delegate.dart';
import 'package:movs4u/ui/screens/films_list_item.dart';
import 'package:movs4u/utils/app_constants.dart';

class MosalsalatWidget extends StatefulWidget {
  @override
  _MosalsalatWidgetState createState() => _MosalsalatWidgetState();
}

class _MosalsalatWidgetState extends State<MosalsalatWidget> {
  int itemMenuClickedId = 0;
  double screenWidth;
  double screenHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainCategoryBloc.fetchAllMainCategories('series');
    mainCategoryPostsBloc.fetchAllMainCategoriesPosts('1');
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      shrinkWrap: false,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          height: 50.0,
          child: StreamBuilder(
              stream: mainCategoryBloc.mainCategories,
              builder:
                  (context, AsyncSnapshot<MainCategoryItemModel> snapshot) {
                if (snapshot.hasData) {
                  return buildMainCategoryList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return SizedBox();
                /*Center(
              child: Container(
                  width: 7.0, height: 7.0, child: CircularProgressIndicator()),
            );*/
              }),
        ),
        Container(
          height: screenHeight,
          child: StreamBuilder(
            stream: mainCategoryPostsBloc.mainCategoryPosts,
            builder:
                (context, AsyncSnapshot<MainCategoryItemPostsModel> snapshot) {
              if (snapshot.hasData) {
                return buildMainCategoryPostsList(snapshot);
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildMainCategoryList(AsyncSnapshot<MainCategoryItemModel> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.data.length,
      itemBuilder: (context, int position) {
        return Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
                  child: Text(
                    ' ${snapshot.data.data[position].name}',
                    style: TextStyle(
                        color: itemMenuClickedId == position
                            ? AppConstants.buttonColor
                            : Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() {
                    itemMenuClickedId = position;
                    mainCategoryPostsBloc.fetchAllMainCategoriesPosts(
                        snapshot.data.data[position].id.toString());
                  });
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              itemMenuClickedId == position
                  ? Center(
                child: Image.asset(
                  'images/hover-icon.png',
                  width: 15.0,
                ),
              )
                  : SizedBox()
            ],
          ),
        );
      },
    );
  }

  Widget buildMainCategoryPostsList(
      AsyncSnapshot<MainCategoryItemPostsModel> snapshot) {
    return Container(
      color: AppConstants.primaryColor,
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        itemCount: snapshot.data.postData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.5),
        ),
        itemBuilder: (BuildContext context, int position) {
          return filmListItem(snapshot, 120.0, position, 20.0,context);
        },
      ),
    );
  }
}
