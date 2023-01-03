class UserModel {
  final String? uid;
  final String? code;

  UserModel({this.uid, this.code});
}

class UserModelData {
  final String uid;
  final String name;
  final String sugar;
  final int strength;

  UserModelData(
      {required this.uid,
      required this.name,
      required this.sugar,
      required this.strength});
}
