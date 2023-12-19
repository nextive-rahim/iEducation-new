// To parse this JSON data, do
//
//     final blogDetailModel = blogDetailModelFromJson(jsonString);

import 'dart:convert';

BlogDetailModel blogDetailModelFromJson(String str) =>
    BlogDetailModel.fromJson(json.decode(str));

String blogDetailModelToJson(BlogDetailModel data) =>
    json.encode(data.toJson());

class BlogDetailModel {
  BlogDetailModel({
    this.data,
  });

  BlogDetailData? data;

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) =>
      BlogDetailModel(
        data:
            json["data"] == null ? null : BlogDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class BlogDetailData {
  BlogDetailData({
    this.id,
    this.userId,
    this.approvedBy,
    this.title,
    this.subtitle,
    this.slug,
    this.body,
    this.photo,
    this.video,
    this.order,
    this.active,
    this.createdAt,
    this.categories,
    this.user,
  });

  int? id;
  dynamic userId;
  dynamic approvedBy;
  String? title;
  dynamic subtitle;
  String? slug;
  String? body;
  String? photo;
  String? video;
  int? order;
  bool? active;
  DateTime? createdAt;
  List<Category>? categories;
  dynamic user;

  factory BlogDetailData.fromJson(Map<String, dynamic> json) => BlogDetailData(
        id: json["id"],
        userId: json["user_id"],
        approvedBy: json["approved_by"],
        title: json["title"],
        subtitle: json["subtitle"],
        slug: json["slug"],
        body: json["body"],
        photo: json["photo"],
        video: json["video"],
        order: json["order"],
        active: json["active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "approved_by": approvedBy,
        "title": title,
        "subtitle": subtitle,
        "slug": slug,
        "body": body,
        "photo": photo,
        "video": video,
        "order": order,
        "active": active,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "user": user,
      };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
