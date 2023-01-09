// To parse this JSON data, do
//
//     final addInsiderResponseModel = addInsiderResponseModelFromJson(jsonString);

import 'dart:convert';

AddInsiderResponseModel? addInsiderResponseModelFromJson(String str) =>
    AddInsiderResponseModel.fromJson(json.decode(str));

String addInsiderResponseModelToJson(AddInsiderResponseModel? data) =>
    json.encode(data!.toJson());

class AddInsiderResponseModel {
  AddInsiderResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddInsiderResponseModel.fromJson(Map<String, dynamic> json) =>
      AddInsiderResponseModel(
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
    this.sharesSold,
    this.sharesBought,
    this.id,
    this.companyId,
    this.createdAt,
    this.table,
    this.updateDate,
    this.updatedAt,
  });

  Shares? sharesSold;
  Shares? sharesBought;
  String? id;
  String? companyId;
  DateTime? createdAt;
  List<Table?>? table;
  DateTime? updateDate;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sharesSold: Shares.fromJson(json["sharesSold"]),
        sharesBought: Shares.fromJson(json["sharesBought"]),
        id: json["_id"],
        companyId: json["companyId"],
        createdAt: DateTime.parse(json["createdAt"]),
        table: json["table"] == null
            ? []
            : List<Table?>.from(json["table"]!.map((x) => Table.fromJson(x))),
        updateDate: DateTime.parse(json["updateDate"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "sharesSold": sharesSold!.toJson(),
        "sharesBought": sharesBought!.toJson(),
        "_id": id,
        "companyId": companyId,
        "createdAt": createdAt?.toIso8601String(),
        "table": table == null
            ? []
            : List<dynamic>.from(table!.map((x) => x!.toJson())),
        "updateDate": updateDate?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Shares {
  Shares({
    this.shares,
    this.person,
  });

  int? shares;
  int? person;

  factory Shares.fromJson(Map<String, dynamic> json) => Shares(
        shares: json["shares"],
        person: json["person"],
      );

  Map<String, dynamic> toJson() => {
        "shares": shares,
        "person": person,
      };
}

class Table {
  Table({
    this.personCategory,
    this.shares,
    this.value,
    this.transactionType,
    this.mode,
    this.id,
  });

  String? personCategory;
  int? shares;
  int? value;
  String? transactionType;
  String? mode;
  String? id;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        personCategory: json["personCategory"],
        shares: json["shares"],
        value: json["value"],
        transactionType: json["transactionType"],
        mode: json["mode"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "personCategory": personCategory,
        "shares": shares,
        "value": value,
        "transactionType": transactionType,
        "mode": mode,
        "_id": id,
      };
}
