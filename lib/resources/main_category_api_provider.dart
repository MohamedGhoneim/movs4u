import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:movs4u/models/main_category_item_model.dart';
import 'package:movs4u/utils/app_constants.dart';

class MainCategoryApiProvider {
  Client client = new Client();

  Future<MainCategoryItemModel> fetchMainCategoryList(String type) async {

    final response = await client
        .get('${AppConstants.baseUrl}api/categories?type=$type');

    print(response.body.toString());

    if(response.statusCode==200){
      // if the call to the server was successful, parse the json

      return MainCategoryItemModel.fromJson(json.decode(response.body));
    }else {
      // if that was not successful, throw an error
      throw Exception('Faild to load post');
    }

  }
}
