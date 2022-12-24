// To parse this JSON data, do
//
//     final addNewsCategoriesResponseModel = addNewsCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

AddNewsCategoriesResponseModel addNewsCategoriesResponseModelFromJson(
        String str) =>
    AddNewsCategoriesResponseModel.fromJson(json.decode(str));

String addNewsCategoriesResponseModelToJson(
        AddNewsCategoriesResponseModel data) =>
    json.encode(data.toJson());

class AddNewsCategoriesResponseModel {
  AddNewsCategoriesResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddNewsCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      AddNewsCategoriesResponseModel(
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
    this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
