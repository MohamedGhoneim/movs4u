import 'dart:async';

import 'package:movs4u/models/main_category_item_model.dart';
import 'package:movs4u/models/main_category_item_posts_model.dart';

import 'main_category_api_provider.dart';
import 'main_category_posts_api_provider.dart';

class Repository {
  final _mainCategoryApiProvider = MainCategoryApiProvider();
  final _mainCategoryPostsApiProvider = MainCategoryPostsApiProvider();

  Future<MainCategoryItemModel> fetchAllMainCategories(String type) => _mainCategoryApiProvider.fetchMainCategoryList(type);
  Future<MainCategoryItemPostsModel> fetchAllMainPostsCategories(String id) => _mainCategoryPostsApiProvider.fetchMainCategoryPostsList(id);
}
