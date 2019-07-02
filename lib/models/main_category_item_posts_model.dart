class MainCategoryItemPostsModel {
  int _current_page;
  List<_PostsData> _postsData = [];

  MainCategoryItemPostsModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['data']['posts'].length);
    _current_page = parsedJson['data']['posts']['current_page'];
    List<_PostsData> temp = [];
    for (int i = 0; i < parsedJson['data']['posts']['data'].length; i++) {
      _PostsData data = _PostsData(parsedJson['data']['posts']['data'][i]);

      temp.add(data);
    }
    _postsData = temp;
  }

  int get currentPage => _current_page;

  List<_PostsData> get postData => _postsData;
}

class _PostsData {
  int _id;
  int _author_id;
  int _category_id;
  String _title;
  String _seo_title;
  String _link;
  String _excerpt;
  String _body;
  String _image;
  String _slug;
  String _meta_description;
  String _meta_keywords;
  String _status;
  int _featured;
  String _created_at;
  String _updated_at;
  String _categoryName;

  _PostsData(postsData) {
    _id = postsData['id'];
    _author_id = postsData['author_id'];
    _category_id = postsData['category_id'];
    _title = postsData['title'];
    _seo_title = postsData['seo_title'];
    _link = postsData['link'];
    _excerpt = postsData['excerpt'];
    _body = postsData['body'];
    _image = postsData['image'];
    _slug = postsData['slug'];
    _meta_description = postsData['meta_description'];
    _meta_keywords = postsData['meta_keywords'];
    _status = postsData['status'];
    _featured = postsData['featured'];
    _created_at = postsData['created_at'];
    _updated_at = postsData['updated_at'];
    _categoryName = postsData['category_name'];
  }

  int get id => _id;

  int get author_id => _author_id;

  int get category_id => _category_id;

  String get title => _title;

  String get seo_title => _seo_title;

  String get link => _link;

  String get excerpt => _excerpt;

  String get body => _body;

  String get image => _image;

  String get slug => _slug;

  String get meta_description => _meta_description;

  String get meta_keywords => _meta_keywords;

  String get status => _status;

  int get featured => _featured;

  String get created_at => _created_at;

  String get updated_at => _updated_at;
  String get categoryName => _categoryName;
}
