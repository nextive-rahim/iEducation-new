// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
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
  dynamic phoneVerifiedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    photo: json["photo"],
    phone: json["phone"],
    email: json["email"],
    type: json["type"],
    gender: json["gender"],
    dob: json["dob"],
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
    "dob": dob == null,
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
