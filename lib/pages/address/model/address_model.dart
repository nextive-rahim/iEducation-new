// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.data,
  });

  List<AddressModelData>? data;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        data: json["data"] == null
            ? null
            : List<AddressModelData>.from(
                json["data"].map((x) => AddressModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AddressModelData {
  AddressModelData({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.email,
    this.house,
    this.road,
    this.postOffice,
    this.postCode,
    this.village,
    this.city,
    this.country,
    this.subDistrict,
    this.district,
    this.division,
    this.state,
    this.floor,
    this.flat,
    this.body,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  int? id;
  int? userId;
  String? name;
  String? phone;
  dynamic email;
  dynamic house;
  dynamic road;
  dynamic postOffice;
  dynamic postCode;
  dynamic village;
  dynamic city;
  dynamic country;
  dynamic subDistrict;
  dynamic district;
  dynamic division;
  dynamic state;
  dynamic floor;
  dynamic flat;
  dynamic body;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;

  factory AddressModelData.fromJson(Map<String, dynamic> json) =>
      AddressModelData(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        house: json["house"],
        road: json["road"],
        postOffice: json["post_office"],
        postCode: json["post_code"],
        village: json["village"],
        city: json["city"],
        country: json["country"],
        subDistrict: json["sub_district"],
        district: json["district"],
        division: json["division"],
        state: json["state"],
        floor: json["floor"],
        flat: json["flat"],
        body: json["body"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "email": email,
        "house": house,
        "road": road,
        "post_office": postOffice,
        "post_code": postCode,
        "village": village,
        "city": city,
        "country": country,
        "sub_district": subDistrict,
        "district": district,
        "division": division,
        "state": state,
        "floor": floor,
        "flat": flat,
        "body": body,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "address": address,
      };
}
