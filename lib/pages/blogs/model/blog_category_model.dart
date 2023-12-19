// To parse this JSON data, do
//
//     final blogCategoryModel = blogCategoryModelFromJson(jsonString);

import 'dart:convert';

BlogCategoryModel blogCategoryModelFromJson(String str) =>
    BlogCategoryModel.fromJson(json.decode(str));

String blogCategoryModelToJson(BlogCategoryModel data) =>
    json.encode(data.toJson());

class BlogCategoryModel {
  BlogCategoryModel({
    this.data,
  });

  List<BlogCategoryListData>? data;

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) =>
      BlogCategoryModel(
        data: json["data"] == null
            ? null
            : List<BlogCategoryListData>.from(
                json["data"].map((x) => BlogCategoryListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BlogCategoryListData {
  BlogCategoryListData({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.photo,
    this.order,
    this.active,
    this.children,
    this.childrenCount,
  });

  int? id;
  dynamic parentId;
  String? name;
  String? slug;
  dynamic photo;
  int? order;
  bool? active;
  List<dynamic>? children;
  int? childrenCount;

  factory BlogCategoryListData.fromJson(Map<String, dynamic> json) =>
      BlogCategoryListData(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"],
        order: json["order"],
        active: json["active"],
        children: json["children"] == null
            ? null
            : List<dynamic>.from(json["children"].map((x) => x)),
        childrenCount:
            json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "slug": slug,
        "photo": photo,
        "order": order,
        "active": active,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
        "children_count": childrenCount,
      };
}
