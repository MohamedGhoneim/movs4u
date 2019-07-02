import 'package:movs4u/models/main_category_item_posts_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class MainCategoryPostsBloc{
  final _repository = Repository();
  final _mainCategoryPostsFetcher = PublishSubject<MainCategoryItemPostsModel>();

  Observable<MainCategoryItemPostsModel> get mainCategoryPosts =>
      _mainCategoryPostsFetcher.stream;

  fetchAllMainCategoriesPosts(String id) async{
    MainCategoryItemPostsModel itemModel = await _repository.fetchAllMainPostsCategories(id);
    _mainCategoryPostsFetcher.sink.add(itemModel);
  }
  dispose(){
    _mainCategoryPostsFetcher.close();
  }

}

final mainCategoryPostsBloc = MainCategoryPostsBloc();