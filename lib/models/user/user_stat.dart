
import 'dart:convert';

class UserStat {
  UserOwe? userOwe;
  List<BillModel>? orders;

  UserStat({
    this.userOwe,
    this.orders,
  });

  factory UserStat.fromRawJson(String str) => UserStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserStat.fromJson(Map<String, dynamic> json) => UserStat(
    userOwe: json["user_owe"] == null ? null : UserOwe.fromJson(json["user_owe"]),
    orders: json["orders"] == null ? [] : List<BillModel>.from(json["orders"]!.map((x) => BillModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_owe": userOwe?.toJson(),
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class BillModel {
  DateTime? createdAt;
  double? totalPrice;
  int? groupId;
  int? totalMembers;
  String? title;
  int? id;
  DateTime? updatedAt;
  int? hostId;
  List<int>? listId;
  int? typeOrder;

  BillModel({
    this.createdAt,
    this.totalPrice,
    this.groupId,
    this.totalMembers,
    this.title,
    this.id,
    this.updatedAt,
    this.hostId,
    this.listId,
    this.typeOrder,
  });

  factory BillModel.fromRawJson(String str) => BillModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    totalPrice: json["total_price"],
    groupId: json["group_id"],
    totalMembers: json["total_members"],
    title: json["title"],
    id: json["id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    hostId: json["host_id"],
    listId: json["list_id"] == null ? [] : List<int>.from(json["list_id"]!.map((x) => x)),
    typeOrder: json["type_order"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "total_price": totalPrice,
    "group_id": groupId,
    "total_members": totalMembers,
    "title": title,
    "id": id,
    "updated_at": updatedAt?.toIso8601String(),
    "host_id": hostId,
    "list_id": listId == null ? [] : List<dynamic>.from(listId!.map((x) => x)),
    "type_order": typeOrder,
  };
}

class UserOwe {
  int? id;
  int? userId;
  double? own;
  double? userOwe;
  dynamic createdAt;
  dynamic updatedAt;

  UserOwe({
    this.id,
    this.userId,
    this.own,
    this.userOwe,
    this.createdAt,
    this.updatedAt,
  });

  factory UserOwe.fromRawJson(String str) => UserOwe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserOwe.fromJson(Map<String, dynamic> json) => UserOwe(
    id: json["id"],
    userId: json["user_id"],
    own: json["own"],
    userOwe: json["user_owe"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "own": own,
    "user_owe": userOwe,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}