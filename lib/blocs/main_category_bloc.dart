import 'package:movs4u/models/main_category_item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class MainCategoryBloc{
  final _repository = Repository();
  final _mainCategoryFetcher = PublishSubject<MainCategoryItemModel>();

  Observable<MainCategoryItemModel> get mainCategories =>
      _mainCategoryFetcher.stream;

  fetchAllMainCategories(String type) async{
    MainCategoryItemModel itemModel = await _repository.fetchAllMainCategories(type);
    _mainCategoryFetcher.sink.add(itemModel);
  }
  dispose(){
    _mainCategoryFetcher.close();
  }

}

final mainCategoryBloc = MainCategoryBloc();