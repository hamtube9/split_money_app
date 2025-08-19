
import 'dart:convert';

class RegisterResponse {
  String? name;
  String? email;
  int? id;

  RegisterResponse({
    this.name,
    this.email,
    this.id,
  });

  factory RegisterResponse.fromRawJson(String str) => RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    name: json["name"],
    email: json["email"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "id": id,
  };
}