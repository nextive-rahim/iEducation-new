// To parse this JSON data, do
//
//     final deliveryOptionModel = deliveryOptionModelFromJson(jsonString);

import 'dart:convert';

DeliveryOptionModel deliveryOptionModelFromJson(String str) =>
    DeliveryOptionModel.fromJson(json.decode(str));

String deliveryOptionModelToJson(DeliveryOptionModel data) =>
    json.encode(data.toJson());

class DeliveryOptionModel {
  DeliveryOptionModel({
    this.data,
  });

  List<DeliveryOptionData>? data;

  factory DeliveryOptionModel.fromJson(Map<String, dynamic> json) =>
      DeliveryOptionModel(
        data: json["data"] == null
            ? null
            : List<DeliveryOptionData>.from(
                json["data"].map((x) => DeliveryOptionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DeliveryOptionData {
  DeliveryOptionData({
    this.id,
    this.name,
    this.photo,
    this.fee,
    this.description,
  });

  int? id;
  String? name;
  dynamic photo;
  String? fee;
  dynamic description;

  factory DeliveryOptionData.fromJson(Map<String, dynamic> json) =>
      DeliveryOptionData(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        fee: json["fee"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "fee": fee,
        "description": description,
      };
}
