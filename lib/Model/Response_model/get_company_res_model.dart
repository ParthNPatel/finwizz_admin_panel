// To parse this JSON data, do
//
//     final getCompanyResponseModel = getCompanyResponseModelFromJson(jsonString);

import 'dart:convert';

GetCompanyResponseModel? getCompanyResponseModelFromJson(String str) =>
    GetCompanyResponseModel.fromJson(json.decode(str));

String getCompanyResponseModelToJson(GetCompanyResponseModel? data) =>
    json.encode(data!.toJson());

class GetCompanyResponseModel {
  GetCompanyResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum?>? data;

  factory GetCompanyResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyResponseModel(
        flag: json["flag"],
        data: json["data"] == null
            ? []
            : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.shortName,
    this.datumId,
  });

  String? id;
  String? name;
  String? shortName;
  String? datumId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        shortName: json["shortName"],
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "shortName": shortName,
        "id": datumId,
      };
}
