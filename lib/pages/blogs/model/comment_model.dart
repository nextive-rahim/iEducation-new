// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.data,
    this.links,
    this.meta,
  });

  List<CommentListData>? data;
  Links? links;
  Meta? meta;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        data: json["data"] == null
            ? null
            : List<CommentListData>.from(
                json["data"].map((x) => CommentListData.fromJson(x))),
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

class CommentListData {
  CommentListData({
    this.id,
    this.userId,
    this.photo,
    this.body,
    this.active,
    this.parentId,
    this.commentableId,
    this.user,
    this.children,
    this.createdAt,
  });

  int? id;
  int? userId;
  dynamic photo;
  String? body;
  bool? active;
  dynamic parentId;
  int? commentableId;
  User? user;
  dynamic children;
  String? createdAt;

  factory CommentListData.fromJson(Map<String, dynamic> json) =>
      CommentListData(
        id: json["id"],
        userId: json["user_id"],
        photo: json["photo"],
        body: json["body"],
        active: json["active"],
        parentId: json["parent_id"],
        commentableId:
            json["commentable_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        children: json["children"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "photo": photo,
        "body": body,
        "active": active,
        "parent_id": parentId,
        "commentable_id": commentableId,
        "user": user == null ? null : user!.toJson(),
        "children": children,
        "created_at": createdAt,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.photo,
    this.phone,
    this.email,
    this.currentInstitution,
    this.type,
    this.dob,
    this.approved,
    this.active,
    this.guardiansPhone,
    this.secondTimer,
  });

  int? id;
  String? name;
  String? username;
  String? photo;
  String? phone;
  String? email;
  String? currentInstitution;
  String? type;
  dynamic dob;
  bool? approved;
  bool? active;
  dynamic guardiansPhone;
  bool? secondTimer;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        photo: json["photo"],
        phone: json["phone"],
        email: json["email"],
        currentInstitution: json["current_institution"],
        type: json["type"],
        dob: json["dob"],
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
        "phone": phone,
        "email": email,
        "current_institution":
            currentInstitution,
        "type": type,
        "dob": dob,
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
