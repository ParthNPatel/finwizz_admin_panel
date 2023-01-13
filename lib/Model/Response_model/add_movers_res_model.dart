// To parse this JSON data, do
//
//     final addMoversResponseModel = addMoversResponseModelFromJson(jsonString);

import 'dart:convert';

AddMoversResponseModel addMoversResponseModelFromJson(String str) =>
    AddMoversResponseModel.fromJson(json.decode(str));

String addMoversResponseModelToJson(AddMoversResponseModel data) =>
    json.encode(data.toJson());

class AddMoversResponseModel {
  AddMoversResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddMoversResponseModel.fromJson(Map<String, dynamic> json) =>
      AddMoversResponseModel(
        flag: json["flag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data!?.toJson(),
      };
}

class Data {
  Data({
    this.title,
    this.description,
    this.companyId,
    this.percentage,
    this.startDate,
    this.endDate,
    this.startPrice,
    this.currentPrice,
    this.type,
    this.likes,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? title;
  String? description;
  String? companyId;
  int? percentage;
  String? startDate;
  String? endDate;
  int? startPrice;
  int? currentPrice;
  int? type;
  int? likes;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
        companyId: json["companyId"],
        percentage: json["percentage"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        startPrice: json["startPrice"],
        currentPrice: json["currentPrice"],
        type: json["type"],
        likes: json["likes"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "companyId": companyId,
        "percentage": percentage,
        "startDate": startDate,
        "endDate": endDate,
        "startPrice": startPrice,
        "currentPrice": currentPrice,
        "type": type,
        "likes": likes,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
