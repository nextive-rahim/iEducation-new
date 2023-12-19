// To parse this JSON data, do
//
//     final categoryChildrenModel = categoryChildrenModelFromJson(jsonString);

import 'dart:convert';

CategoryChildrenModel categoryChildrenModelFromJson(String str) =>
    CategoryChildrenModel.fromJson(json.decode(str));

String categoryChildrenModelToJson(CategoryChildrenModel data) =>
    json.encode(data.toJson());

class CategoryChildrenModel {
  CategoryChildrenModel({
    this.data,
  });

  CategoryChildrenData? data;

  factory CategoryChildrenModel.fromJson(Map<String, dynamic> json) =>
      CategoryChildrenModel(
        data: json["data"] == null
            ? null
            : CategoryChildrenData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class CategoryChildrenData {
  CategoryChildrenData({
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
  List<Child>? children;
  int? childrenCount;

  factory CategoryChildrenData.fromJson(Map<String, dynamic> json) =>
      CategoryChildrenData(
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
            : List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
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

class Child {
  Child({
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
  List<Child>? children;
  int? childrenCount;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
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
            : List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
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
