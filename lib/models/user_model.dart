class UserModel {
  int _id;
  String _name;
  String _email;
  String _avatar;
  String _mobile;
  String _createdAt;
  String _updatedAt;
  String _accessToken;
  String _tokenType;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _name = parsedJson['name'];
    _email = parsedJson['email'];
    _avatar = parsedJson['avatar'];
    _mobile = parsedJson['mobile'];
    _createdAt = parsedJson['created_at'];
    _updatedAt = parsedJson['updated_at'];
    _accessToken = parsedJson['access_token'];
    _tokenType = parsedJson['token_type'];
  }

  Map<String, dynamic> toJson() => {
        'id': this._id,
        'name': this._name,
        'email': this._email,
        'avatar': this._avatar,
        'mobile': this._mobile,
        'created_at': this._createdAt,
        'updated_at': this._updatedAt,
        'access_token': this._accessToken,
        'token_type': this._tokenType
      };

  int get id => _id;

  String get name => _name;

  String get email => _email;

  String get avatar => _avatar;

  String get mobile => _mobile;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  String get accessToken => _accessToken;

  String get tokenType => _tokenType;
}

