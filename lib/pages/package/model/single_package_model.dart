// To parse this JSON data, do
//
//     final singlePackageModel = singlePackageModelFromJson(jsonString);

import 'dart:convert';

SinglePackageModel singlePackageModelFromJson(String str) =>
    SinglePackageModel.fromJson(json.decode(str));

String singlePackageModelToJson(SinglePackageModel data) =>
    json.encode(data.toJson());

class SinglePackageModel {
  SinglePackageModel({
    this.data,
  });

  SinglePackageModelData? data;

  factory SinglePackageModel.fromJson(Map<String, dynamic> json) =>
      SinglePackageModel(
        data: json["data"] == null
            ? null
            : SinglePackageModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class SinglePackageModelData {
  SinglePackageModelData({
    this.id,
    this.createdBy,
    this.title,
    this.slug,
    this.video,
    this.photo,
    this.subtitle,
    this.description,
    this.difficulty,
    this.language,
    this.requirement,
    this.outcome,
    this.featured,
    this.duration,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.approved,
    this.active,
    this.courseFeatures,
    this.subscriptionStatus,
    this.coupons,
    this.courses,
    this.requireGuardiansPhone,
    this.rating,
    this.usersCount,
    this.userCount,
    this.videoCount,
    this.audioCount,
    this.examCount,
    this.pdfCount,
    this.noteCount,
    this.linkCount,
    this.liveCount,
    this.zipCount,
    this.fileCount,
    this.writtenExamCount,
    this.reviews,
    this.users,
    this.fakeUserCount,
    this.reviewsCount,
  });

  int? id;
  int? createdBy;
  String? title;
  String? slug;
  dynamic video;
  String? photo;
  dynamic subtitle;
  String? description;
  dynamic difficulty;
  dynamic language;
  dynamic requirement;
  dynamic outcome;
  bool? featured;
  int? duration;
  String? price;
  String? discount;
  DateTime? discountTill;
  String? discountedPrice;
  bool? approved;
  bool? active;
  List<dynamic>? courseFeatures;
  dynamic subscriptionStatus;
  List<dynamic>? coupons;
  List<SinglePackageModelData>? courses;
  bool? requireGuardiansPhone;
  int? rating;
  dynamic usersCount;
  dynamic userCount;
  int? videoCount;
  dynamic audioCount;
  dynamic examCount;
  dynamic pdfCount;
  dynamic noteCount;
  dynamic linkCount;
  dynamic liveCount;
  dynamic zipCount;
  dynamic fileCount;
  dynamic writtenExamCount;
  List<dynamic>? reviews;
  List<dynamic>? users;
  dynamic fakeUserCount;
  int? reviewsCount;

  factory SinglePackageModelData.fromJson(Map<String, dynamic> json) =>
      SinglePackageModelData(
        id: json["id"],
        createdBy: json["created_by"],
        title: json["title"],
        slug: json["slug"],
        video: json["video"],
        photo: json["photo"],
        subtitle: json["subtitle"],
        description: json["description"],
        difficulty: json["difficulty"],
        language: json["language"],
        requirement: json["requirement"],
        outcome: json["outcome"],
        featured: json["featured"],
        duration: json["duration"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        discountedPrice:
            json["discounted_price"],
        approved: json["approved"],
        active: json["active"],
        courseFeatures: json["courseFeatures"] == null
            ? null
            : List<dynamic>.from(json["courseFeatures"].map((x) => x)),
        subscriptionStatus: json["subscription_status"],
        coupons: json["coupons"] == null
            ? null
            : List<dynamic>.from(json["coupons"].map((x) => x)),
        courses: json["courses"] == null
            ? null
            : List<SinglePackageModelData>.from(
                json["courses"].map((x) => SinglePackageModelData.fromJson(x))),
        requireGuardiansPhone: json["require_guardians_phone"],
        rating: json["rating"],
        usersCount: json["users_count"],
        userCount: json["user_count"],
        videoCount: json["video_count"],
        audioCount: json["audio_count"],
        examCount: json["exam_count"],
        pdfCount: json["pdf_count"],
        noteCount: json["note_count"],
        linkCount: json["link_count"],
        liveCount: json["live_count"],
        zipCount: json["zip_count"],
        fileCount: json["file_count"],
        writtenExamCount: json["written_exam_count"],
        reviews: json["reviews"] == null
            ? null
            : List<dynamic>.from(json["reviews"].map((x) => x)),
        users: json["users"] == null
            ? null
            : List<dynamic>.from(json["users"].map((x) => x)),
        fakeUserCount: json["fake_user_count"],
        reviewsCount:
            json["reviews_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "title": title,
        "slug": slug,
        "video": video,
        "photo": photo,
        "subtitle": subtitle,
        "description": description,
        "difficulty": difficulty,
        "language": language,
        "requirement": requirement,
        "outcome": outcome,
        "featured": featured,
        "duration": duration,
        "price": price,
        "discount": discount,
        "discount_till":
            discountTill == null ? null : discountTill!.toIso8601String(),
        "discounted_price": discountedPrice,
        "approved": approved,
        "active": active,
        "courseFeatures": courseFeatures == null
            ? null
            : List<dynamic>.from(courseFeatures!.map((x) => x)),
        "subscription_status": subscriptionStatus,
        "coupons":
            coupons == null ? null : List<dynamic>.from(coupons!.map((x) => x)),
        "courses": courses == null
            ? null
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "require_guardians_phone":
            requireGuardiansPhone,
        "rating": rating,
        "users_count": usersCount,
        "user_count": userCount,
        "video_count": videoCount,
        "audio_count": audioCount,
        "exam_count": examCount,
        "pdf_count": pdfCount,
        "note_count": noteCount,
        "link_count": linkCount,
        "live_count": liveCount,
        "zip_count": zipCount,
        "file_count": fileCount,
        "written_exam_count": writtenExamCount,
        "reviews":
            reviews == null ? null : List<dynamic>.from(reviews!.map((x) => x)),
        "users":
            users == null ? null : List<dynamic>.from(users!.map((x) => x)),
        "fake_user_count": fakeUserCount,
        "reviews_count": reviewsCount,
      };
}
