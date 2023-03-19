import 'package:hive/hive.dart';

part 'users.g.dart';

@HiveType(typeId: 0)
class Users {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String token;
  @HiveField(3)
  String username;

  Users(
      {required this.email,
      required this.id,
      required this.token,
      required this.username});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        email: json["email"],
        id: json["id"],
        token: json["token"],
        username: json["username"]);
  }
}
