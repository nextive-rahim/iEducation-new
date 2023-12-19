// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) =>
    AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    this.data,
  });

  AboutUsData? data;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        data: json["data"] == null ? null : AboutUsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class AboutUsData {
  AboutUsData({
    this.id,
    this.key,
    this.value,
    this.active,
  });

  int? id;
  String? key;
  String? value;
  int? active;

  factory AboutUsData.fromJson(Map<String, dynamic> json) => AboutUsData(
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
