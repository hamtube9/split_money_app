
import 'dart:convert';

import 'package:split_money/models/user/user.dart';

class LoginResponse {
  User? user;
  String? accessToken;

  LoginResponse({
    this.user,
    this.accessToken,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "accessToken": accessToken,
  };
}
