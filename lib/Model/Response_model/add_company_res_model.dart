// To parse this JSON data, do
//
//     final addCompanyResponseModel = addCompanyResponseModelFromJson(jsonString);

import 'dart:convert';

AddCompanyResponseModel addCompanyResponseModelFromJson(String str) =>
    AddCompanyResponseModel.fromJson(json.decode(str));

String addCompanyResponseModelToJson(AddCompanyResponseModel data) =>
    json.encode(data.toJson());

class AddCompanyResponseModel {
  AddCompanyResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddCompanyResponseModel.fromJson(Map<String, dynamic> json) =>
      AddCompanyResponseModel(
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
    this.shortName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.dataId,
  });

  String? name;
  String? shortName;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? dataId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        shortName: json["shortName"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        dataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "shortName": shortName,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "id": dataId,
      };
}
