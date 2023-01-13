// To parse this JSON data, do
//
//     final addNewsResponseModel = addNewsResponseModelFromJson(jsonString);

import 'dart:convert';

AddNewsResponseModel addNewsResponseModelFromJson(String str) =>
    AddNewsResponseModel.fromJson(json.decode(str));

String addNewsResponseModelToJson(AddNewsResponseModel data) =>
    json.encode(data.toJson());

class AddNewsResponseModel {
  AddNewsResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddNewsResponseModel.fromJson(Map<String, dynamic> json) =>
      AddNewsResponseModel(
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
    this.title,
    this.description,
    this.categoryId,
    this.companyId,
    this.source,
    this.type,
    this.likes,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? title;
  String? description;
  String? categoryId;
  String? companyId;
  String? source;
  int? type;
  int? likes;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
        categoryId: json["categoryId"],
        companyId: json["companyId"],
        source: json["source"],
        type: json["type"],
        likes: json["likes"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "categoryId": categoryId,
        "companyId": companyId,
        "source": source,
        "type": type,
        "likes": likes,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
