// To parse this JSON data, do
//
//     final getNewsCategoriesResponseModel = getNewsCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

GetNewsCategoriesResponseModel getNewsCategoriesResponseModelFromJson(
        String str) =>
    GetNewsCategoriesResponseModel.fromJson(json.decode(str));

String getNewsCategoriesResponseModelToJson(
        GetNewsCategoriesResponseModel data) =>
    json.encode(data.toJson());

class GetNewsCategoriesResponseModel {
  GetNewsCategoriesResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetNewsCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      GetNewsCategoriesResponseModel(
        flag: json["flag"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
