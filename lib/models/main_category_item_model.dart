class MainCategoryItemModel{
  List<_Data> _data = [];

  MainCategoryItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['data'].length);
    List<_Data> temp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      _Data data = _Data(parsedJson['data'][i]);

      temp.add(data);
    }
    _data = temp;
  }

  List<_Data> get data => _data;


}


class _Data {
  int _id;
  String _name;
  String _description;
  String _createdAt;
  String _updatedAt;
  String _image;
  String _type;
  String _parentCategory;

  _Data(data) {
    _id = data['id'];
    _name = data['name'];
    _description = data['description'];
    _createdAt = data['created_at'];
    _updatedAt = data['updated_at'];
    _image = data['image'];
    _type = data['type'];
    _parentCategory = data['parent_category'];

  }

  int get id => _id;

  String get name => _name;

  String get description => _description;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  String get image => _image;

  String get type => _type;

  String get parentCategory => _parentCategory;
}
