// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  BlogModel({
    this.data,
    this.links,
    this.meta,
  });

  List<BlogDataList>? data;
  Links? links;
  Meta? meta;

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        data: json["data"] == null
            ? null
            : List<BlogDataList>.from(
                json["data"].map((x) => BlogDataList.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links == null ? null : links!.toJson(),
        "meta": meta == null ? null : meta!.toJson(),
      };
}

class BlogDataList {
  BlogDataList({
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
  int? userId;
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
  User? user;

  factory BlogDataList.fromJson(Map<String, dynamic> json) => BlogDataList(
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "user": user == null ? null : user!.toJson(),
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
  dynamic name;
  dynamic slug;
  dynamic photo;
  int? order;
  bool? active;
  List<dynamic>? children;
  int? childrenCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"] == null,
        slug: json["slug"] == null,
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
        "name": name == null,
        "slug": slug == null,
        "photo": photo,
        "order": order,
        "active": active,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
        "children_count": childrenCount,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.photo,
    this.currentInstitution,
    this.type,
    this.approved,
    this.active,
    this.guardiansPhone,
    this.secondTimer,
  });

  int? id;
  dynamic name;
  dynamic username;
  String? photo;
  dynamic currentInstitution;
  dynamic type;
  bool? approved;
  bool? active;
  dynamic guardiansPhone;
  bool? secondTimer;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] == null,
        username: json["username"],
        photo: json["photo"],
        currentInstitution: json["current_institution"],
        type: json["type"],
        approved: json["approved"],
        active: json["active"],
        guardiansPhone: json["guardians_phone"],
        secondTimer: json["second_timer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "photo": photo,
        "current_institution": currentInstitution,
        "type": type,
        "approved": approved,
        "active": active,
        "guardians_phone": guardiansPhone,
        "second_timer": secondTimer,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
