// To parse this JSON data, do
//
//     final courseChildrenModel = courseChildrenModelFromJson(jsonString);

import 'dart:convert';

CourseChildrenModel courseChildrenModelFromJson(String str) =>
    CourseChildrenModel.fromJson(json.decode(str));

String courseChildrenModelToJson(CourseChildrenModel data) =>
    json.encode(data.toJson());

class CourseChildrenModel {
  CourseChildrenModel({
    this.data,
    this.extra,
    this.links,
    this.meta,
  });

  List<CourseChildrenData>? data;
  Extra? extra;
  Links? links;
  Meta? meta;

  factory CourseChildrenModel.fromJson(Map<String, dynamic> json) =>
      CourseChildrenModel(
        data: json["data"] == null
            ? null
            : List<CourseChildrenData>.from(
                json["data"].map((x) => CourseChildrenData.fromJson(x))),
        extra: json["extra"] == null ? null : Extra.fromJson(json["extra"]),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "extra": extra == null ? null : extra!.toJson(),
        "links": links == null ? null : links!.toJson(),
        "meta": meta == null ? null : meta!.toJson(),
      };
}

class CourseChildrenData {
  CourseChildrenData({
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
    this.requireGuardiansPhone,
    this.rating,
    this.usersCount,
    this.fakeUserCount,
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
  });

  int? id;
  int? createdBy;
  String? title;
  String? slug;
  dynamic video;
  String? photo;
  dynamic subtitle;
  String? description;
  String? difficulty;
  String? language;
  dynamic requirement;
  dynamic outcome;
  bool? featured;
  int? duration;
  String? price;
  dynamic discount;
  DateTime? discountTill;
  String? discountedPrice;
  bool? approved;
  bool? active;
  List<dynamic>? courseFeatures;
  dynamic subscriptionStatus;
  bool? requireGuardiansPhone;
  double? rating;
  int? usersCount;
  int? fakeUserCount;
  dynamic videoCount;
  dynamic audioCount;
  dynamic examCount;
  dynamic pdfCount;
  dynamic noteCount;
  dynamic linkCount;
  dynamic liveCount;
  dynamic zipCount;
  dynamic fileCount;
  dynamic writtenExamCount;

  factory CourseChildrenData.fromJson(Map<String, dynamic> json) =>
      CourseChildrenData(
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
        requireGuardiansPhone: json["require_guardians_phone"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        usersCount: json["users_count"],
        fakeUserCount:
            json["fake_user_count"],
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
        "require_guardians_phone":
            requireGuardiansPhone,
        "rating": rating,
        "users_count": usersCount,
        "fake_user_count": fakeUserCount,
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
      };
}

class Extra {
  Extra({
    this.max,
    this.min,
  });

  int? max;
  int? min;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        max: json["max"],
        min: json["min"],
      );

  Map<String, dynamic> toJson() => {
        "max": max,
        "min": min,
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
