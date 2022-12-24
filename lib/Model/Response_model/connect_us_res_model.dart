// To parse this JSON data, do
//
//     final connectUsResponseModel = connectUsResponseModelFromJson(jsonString);

import 'dart:convert';

ConnectUsResponseModel connectUsResponseModelFromJson(String str) =>
    ConnectUsResponseModel.fromJson(json.decode(str));

String connectUsResponseModelToJson(ConnectUsResponseModel data) =>
    json.encode(data.toJson());

class ConnectUsResponseModel {
  ConnectUsResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory ConnectUsResponseModel.fromJson(Map<String, dynamic> json) =>
      ConnectUsResponseModel(
        flag: json["flag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.docs,
    this.total,
    this.limit,
    this.page,
    this.pages,
  });

  List<Doc>? docs;
  int? total;
  String? limit;
  String? page;
  int? pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
        total: json["total"],
        limit: json["limit"],
        page: json["page"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs!.map((x) => x.toJson())),
        "total": total,
        "limit": limit,
        "page": page,
        "pages": pages,
      };
}

class Doc {
  Doc({
    this.id,
    this.name,
    this.email,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? email;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "message": message,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
