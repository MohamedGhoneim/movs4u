import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:movs4u/models/main_category_item_posts_model.dart';
import 'package:movs4u/utils/app_constants.dart';

class MainCategoryPostsApiProvider {
  Client client = new Client();

  Future<MainCategoryItemPostsModel> fetchMainCategoryPostsList(String id) async {

    final response = await client
        .get('${AppConstants.baseUrl}api/categories/$id');

    print(response.body.toString());

    if(response.statusCode==200){
      // if the call to the server was successful, parse the json

      return MainCategoryItemPostsModel.fromJson(json.decode(response.body));
    }else {
      // if that was not successful, throw an error
      throw Exception('Faild to load post');
    }

  }
}
