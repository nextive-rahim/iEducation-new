// To parse this JSON data, do
//
//     final courseCategoryModel = courseCategoryModelFromJson(jsonString);

import 'dart:convert';

CourseCategoryModel courseCategoryModelFromJson(String str) =>
    CourseCategoryModel.fromJson(json.decode(str));

String courseCategoryModelToJson(CourseCategoryModel data) =>
    json.encode(data.toJson());

class CourseCategoryModel {
  CourseCategoryModel({
    this.data,
  });

  List<CourseCategoryData>? data;

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) =>
      CourseCategoryModel(
        data: json["data"] == null
            ? null
            : List<CourseCategoryData>.from(
                json["data"].map((x) => CourseCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CourseCategoryData {
  CourseCategoryData({
    this.id,
    this.parentId,
    this.name,
    this.title,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.slug,
    this.photo,
    this.description,
    this.order,
    this.active,
    this.featured,
    this.children,
    this.childrenCount,
  });

  int? id;
  dynamic parentId;
  String? name;
  dynamic title;
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  String? slug;
  String? photo;
  String? description;
  dynamic order;
  bool? active;
  bool? featured;
  List<DatumChild>? children;
  int? childrenCount;

  factory CourseCategoryData.fromJson(Map<String, dynamic> json) =>
      CourseCategoryData(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        title: json["title"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        slug: json["slug"],
        photo: json["photo"],
        description: json["description"],
        order: json["order"],
        active: json["active"],
        featured: json["featured"],
        children: json["children"] == null
            ? null
            : List<DatumChild>.from(
                json["children"].map((x) => DatumChild.fromJson(x))),
        childrenCount:
            json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "title": title,
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "slug": slug,
        "photo": photo,
        "description": description,
        "order": order,
        "active": active,
        "featured": featured,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "children_count": childrenCount,
      };
}

class DatumChild {
  DatumChild({
    this.id,
    this.parentId,
    this.name,
    this.title,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.slug,
    this.photo,
    this.description,
    this.order,
    this.active,
    this.featured,
    this.children,
    this.childrenCount,
  });

  int? id;
  int? parentId;
  String? name;
  dynamic title;
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  String? slug;
  String? photo;
  dynamic description;
  dynamic order;
  bool? active;
  bool? featured;
  List<ChildChild>? children;
  int? childrenCount;

  factory DatumChild.fromJson(Map<String, dynamic> json) => DatumChild(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        title: json["title"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        slug: json["slug"],
        photo: json["photo"],
        description: json["description"],
        order: json["order"],
        active: json["active"],
        featured: json["featured"],
        children: json["children"] == null
            ? null
            : List<ChildChild>.from(
                json["children"].map((x) => ChildChild.fromJson(x))),
        childrenCount:
            json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "title": title,
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "slug": slug,
        "photo": photo,
        "description": description,
        "order": order,
        "active": active,
        "featured": featured,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "children_count": childrenCount,
      };
}

class ChildChild {
  ChildChild({
    this.id,
    this.parentId,
    this.name,
    this.title,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.slug,
    this.photo,
    this.description,
    this.order,
    this.active,
    this.featured,
    this.children,
    this.childrenCount,
  });

  int? id;
  int? parentId;
  String? name;
  dynamic title;
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  String? slug;
  String? photo;
  dynamic description;
  dynamic order;
  bool? active;
  bool? featured;
  List<ChildChild>? children;
  int? childrenCount;

  factory ChildChild.fromJson(Map<String, dynamic> json) => ChildChild(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        title: json["title"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        slug: json["slug"],
        photo: json["photo"],
        description: json["description"],
        order: json["order"],
        active: json["active"],
        featured: json["featured"],
        children: json["children"] == null
            ? null
            : List<ChildChild>.from(
                json["children"].map((x) => ChildChild.fromJson(x))),
        childrenCount:
            json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "title": title,
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "slug": slug,
        "photo": photo,
        "description": description,
        "order": order,
        "active": active,
        "featured": featured,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "children_count": childrenCount,
      };
}
