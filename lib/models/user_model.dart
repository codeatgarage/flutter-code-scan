class UserModel {
  String userName;
  String password;
  String clientId;
  int id;

  UserModel({
    this.userName,
    this.password,
    this.clientId,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      userName: parsedJson['userName'],
      password: parsedJson['password'],
      clientId: parsedJson['clientId'],
      id: parsedJson['id'],
    );
  }

  UserModel.fromMapObject(Map<String, dynamic> map) {
    this.userName = map['userName'];
    this.password = map['password'];
    this.clientId = map['clientId'];
    this.id = map['id'];
  }
}
