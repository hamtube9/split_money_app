
import 'dart:convert';

class User {
  String? name;
  String? email;
  int? id;
  String? role;
  String? avatar;
  String? qr;

  User({
    this.name,
    this.email,
    this.id,
    this.role,
    this.avatar,
    this.qr,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    id: json["id"],
    role: json["role"],
    avatar: json["avatar"],
    qr: json["qr"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "id": id,
    "role": role,
    "avatar": avatar,
    "qr": qr,
  };
}
