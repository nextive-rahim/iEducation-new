// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    this.code,
    this.message,
    this.discount,
    this.valid,
  });

  String? code;
  String? message;
  dynamic discount;
  bool? valid;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        code: json["code"],
        message: json["message"],
        discount:  json["discount"],
        valid: json["valid"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "discount": discount,
        "valid": valid,
      };
}
