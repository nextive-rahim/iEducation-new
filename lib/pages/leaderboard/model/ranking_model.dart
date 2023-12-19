// To parse this JSON data, do
//
//     final rankingModel = rankingModelFromJson(jsonString);

import 'dart:convert';

RankingModel rankingModelFromJson(String str) =>
    RankingModel.fromJson(json.decode(str));

String rankingModelToJson(RankingModel data) => json.encode(data.toJson());

class RankingModel {
  RankingModel({
    this.data,
    this.links,
    this.meta,
  });

  List<RankingListData>? data;
  Links? links;
  Meta? meta;

  factory RankingModel.fromJson(Map<String, dynamic> json) => RankingModel(
        data: json["data"] == null
            ? null
            : List<RankingListData>.from(
                json["data"].map((x) => RankingListData.fromJson(x))),
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

class RankingListData {
  RankingListData({
    this.total,
    this.correct,
    this.submitted,
    this.wrong,
    this.totalMark,
    this.positiveMark,
    this.negativeMark,
    this.obtainedMark,
    this.startTime,
    this.endTime,
    this.subjects,
    this.user,
  });

  dynamic total;
  dynamic correct;
  int? submitted;
  dynamic wrong;
  String? totalMark;
  dynamic positiveMark;
  dynamic negativeMark;
  dynamic obtainedMark;
  DateTime? startTime;
  dynamic endTime;
  dynamic subjects;
  User? user;

  factory RankingListData.fromJson(Map<String, dynamic> json) =>
      RankingListData(
        total: json["total"],
        correct: json["correct"],
        submitted: json["submitted"],
        wrong: json["wrong"],
        totalMark: json["total_mark"],
        positiveMark: json["positive_mark"],
        negativeMark: json["negative_mark"],
        obtainedMark: json["obtained_mark"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime: json["end_time"],
        subjects: json["subjects"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "correct": correct,
        "submitted": submitted,
        "wrong": wrong,
        "total_mark": totalMark,
        "positive_mark": positiveMark,
        "negative_mark": negativeMark,
        "obtained_mark": obtainedMark,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime,
        "subjects": subjects,
        "user": user == null ? null : user!.toJson(),
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
    this.type,
    this.gender,
    this.dob,
    this.affiliation,
    this.subject,
    this.guardiansPhone,
    this.currentInstitution,
    this.varsity,
    this.college,
    this.school,
    this.lastLoginTime,
    this.approved,
    this.active,
    this.secondTimer,
    this.permissions,
    this.roles,
    this.district,
    this.ref,
    this.phoneVerifiedAt,
  });

  int? id;
  String? name;
  String? username;
  dynamic photo;
  String? phone;
  String? email;
  String? type;
  String? gender;
  dynamic dob;
  dynamic affiliation;
  dynamic subject;
  dynamic guardiansPhone;
  String? currentInstitution;
  dynamic varsity;
  dynamic college;
  dynamic school;
  dynamic lastLoginTime;
  bool? approved;
  bool? active;
  bool? secondTimer;
  List<String>? permissions;
  List<String>? roles;
  dynamic district;
  dynamic ref;
  DateTime? phoneVerifiedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        photo: json["photo"],
        phone: json["phone"],
        email: json["email"],
        type: json["type"],
        gender: json["gender"],
        dob: json["dob"] == null,
        affiliation: json["affiliation"],
        subject: json["subject"],
        guardiansPhone: json["guardians_phone"],
        currentInstitution: json["current_institution"],
        varsity: json["varsity"],
        college: json["college"],
        school: json["school"],
        lastLoginTime: json["last_login_time"],
        approved: json["approved"],
        active: json["active"],
        secondTimer: json["second_timer"],
        permissions: json["permissions"] == null
            ? null
            : List<String>.from(json["permissions"].map((x) => x)),
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        district: json["district"],
        ref: json["ref"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : DateTime.parse(json["phone_verified_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "photo": photo,
        "phone": phone,
        "email": email,
        "type": type,
        "gender": gender,
        "dob": dob,
        "affiliation": affiliation,
        "subject": subject,
        "guardians_phone": guardiansPhone,
        "current_institution":
            currentInstitution,
        "varsity": varsity,
        "college": college,
        "school": school,
        "last_login_time": lastLoginTime,
        "approved": approved,
        "active": active,
        "second_timer": secondTimer,
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions!.map((x) => x)),
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "district": district,
        "ref": ref,
        "phone_verified_at":
            phoneVerifiedAt == null ? null : phoneVerifiedAt!.toIso8601String(),
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
