// To parse this JSON data, do
//
//     final pagesModel = pagesModelFromJson(jsonString);

import 'dart:convert';

PagesModel pagesModelFromJson(String str) =>
    PagesModel.fromJson(json.decode(str));

String pagesModelToJson(PagesModel data) => json.encode(data.toJson());

class PagesModel {
  PagesModel({
    this.data,
  });

  List<PageModelData>? data;

  factory PagesModel.fromJson(Map<String, dynamic> json) => PagesModel(
        data: json["data"] == null
            ? null
            : List<PageModelData>.from(
                json["data"].map((x) => PageModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PageModelData {
  PageModelData({
    this.id,
    this.key,
    this.value,
    this.active,
  });

  int? id;
  String? key;
  String? value;
  int? active;

  factory PageModelData.fromJson(Map<String, dynamic> json) => PageModelData(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "active": active,
      };
}
