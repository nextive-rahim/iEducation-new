// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) =>
    NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  NoticeModel({
    this.data,
    this.links,
    this.meta,
  });

  List<NoticeModelData>? data;
  Links? links;
  Meta? meta;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        data: json["data"] == null
            ? null
            : List<NoticeModelData>.from(
                json["data"].map((x) => NoticeModelData.fromJson(x))),
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

class NoticeModelData {
  NoticeModelData({
    this.id,
    this.userId,
    this.approvedBy,
    this.title,
    this.slug,
    this.body,
    this.photo,
    this.order,
    this.active,
    this.type,
    this.createdAt,
    this.categories,
  });

  int? id;
  int? userId;
  dynamic approvedBy;
  String? title;
  String? slug;
  String? body;
  String? photo;
  int? order;
  bool? active;
  String? type;
  DateTime? createdAt;
  List<Category>? categories;

  factory NoticeModelData.fromJson(Map<String, dynamic> json) =>
      NoticeModelData(
        id: json["id"],
        userId: json["user_id"],
        approvedBy: json["approved_by"],
        title: json["title"],
        slug: json["slug"],
        body: json["body"],
        photo: json["photo"],
        order: json["order"],
        active: json["active"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "approved_by": approvedBy,
        "title": title,
        "slug": slug,
        "body": body,
        "photo": photo,
        "order": order,
        "active": active,
        "type": type,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
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
  dynamic order;
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
  dynamic next;

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
