// To parse this JSON data, do
//
//     final freeExamModel = freeExamModelFromJson(jsonString);

import 'dart:convert';

FreeExamModel freeExamModelFromJson(String str) =>
    FreeExamModel.fromJson(json.decode(str));

String freeExamModelToJson(FreeExamModel data) => json.encode(data.toJson());

class FreeExamModel {
  FreeExamModel({
    this.data,
    this.links,
    this.meta,
  });

  List<FreeExamData>? data;
  Links? links;
  Meta? meta;

  factory FreeExamModel.fromJson(Map<String, dynamic> json) => FreeExamModel(
        data: json["data"] == null
            ? null
            : List<FreeExamData>.from(
                json["data"].map((x) => FreeExamData.fromJson(x))),
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

class FreeExamData {
  FreeExamData({
    this.id,
    this.title,
    this.slug,
    this.photo,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.order,
    this.active,
    this.isSubscribed,
    this.categories,
    this.contents,
  });

  int? id;
  String? title;
  String? slug;
  String? photo;
  dynamic price;
  dynamic discount;
  DateTime? discountTill;
  String? discountedPrice;
  dynamic order;
  bool? active;
  bool? isSubscribed;
  List<Category>? categories;
  List<Content>? contents;

  factory FreeExamData.fromJson(Map<String, dynamic> json) => FreeExamData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        photo: json["photo"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        discountedPrice:
            json["discounted_price"],
        order: json["order"],
        active: json["active"],
        isSubscribed:
            json["is_subscribed"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        contents: json["contents"] == null
            ? null
            : List<Content>.from(
                json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "photo": photo,
        "price": price,
        "discount": discount,
        "discount_till":
            discountTill == null ? null : discountTill!.toIso8601String(),
        "discounted_price": discountedPrice,
        "order": order,
        "active": active,
        "is_subscribed": isSubscribed,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "contents": contents == null
            ? null
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.photo,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
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
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
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
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
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
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "order": order,
        "active": active,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
        "children_count": childrenCount,
      };
}

class Content {
  Content({
    this.id,
    this.contentableType,
    this.contentableId,
    this.contentId,
    this.title,
    this.slug,
    this.description,
    this.createdBy,
    this.type,
    this.duration,
    this.photo,
    this.order,
    this.canPreview,
    this.paid,
    this.active,
    this.availableAt,
    this.smsToAll,
    this.exam,
  });

  int? id;
  String? contentableType;
  int? contentableId;
  dynamic contentId;
  String? title;
  String? slug;
  dynamic description;
  int? createdBy;
  String? type;
  String? duration;
  String? photo;
  int? order;
  bool? canPreview;
  bool? paid;
  bool? active;
  DateTime? availableAt;
  bool? smsToAll;
  Exam? exam;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        contentableType:
            json["contentable_type"],
        contentableId:
            json["contentable_id"],
        contentId: json["content_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        createdBy: json["created_by"],
        type: json["type"],
        duration: json["duration"],
        photo: json["photo"],
        order: json["order"],
        canPreview: json["can_preview"],
        paid: json["paid"],
        active: json["active"],
        availableAt: json["available_at"] == null
            ? null
            : DateTime.parse(json["available_at"]),
        smsToAll: json["sms_to_all"],
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentable_type": contentableType,
        "contentable_id": contentableId,
        "content_id": contentId,
        "title": title,
        "slug": slug,
        "description": description,
        "created_by": createdBy,
        "type": type,
        "duration": duration,
        "photo": photo,
        "order": order,
        "can_preview": canPreview,
        "paid": paid,
        "active": active,
        "available_at":
            availableAt == null ? null : availableAt!.toIso8601String(),
        "sms_to_all": smsToAll,
        "exam": exam == null ? null : exam!.toJson(),
      };
}

class Exam {
  Exam({
    this.id,
    this.mode,
    this.duration,
    this.perQuestionMark,
    this.negativeMark,
    this.passMark,
    this.strict,
    this.startTime,
    this.endTime,
    this.resultPublishTime,
    this.totalSubject,
    this.retryLimit,
    this.totalQuestions,
    this.mcqCount,
    this.result,
    this.subjects,
  });

  int? id;
  String? mode;
  int? duration;
  String? perQuestionMark;
  String? negativeMark;
  dynamic passMark;
  bool? strict;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? resultPublishTime;
  int? totalSubject;
  dynamic retryLimit;
  dynamic totalQuestions;
  int? mcqCount;
  Result? result;
  List<dynamic>? subjects;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        mode: json["mode"],
        duration: json["duration"],
        perQuestionMark: json["per_question_mark"],
        negativeMark:
            json["negative_mark"],
        passMark: json["pass_mark"],
        strict: json["strict"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        resultPublishTime: json["result_publish_time"] == null
            ? null
            : DateTime.parse(json["result_publish_time"]),
        totalSubject:
            json["total_subject"],
        retryLimit: json["retry_limit"],
        totalQuestions: json["total_questions"],
        mcqCount: json["mcq_count"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        subjects: json["subjects"] == null
            ? null
            : List<dynamic>.from(json["subjects"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mode": mode,
        "duration": duration,
        "per_question_mark": perQuestionMark,
        "negative_mark": negativeMark,
        "pass_mark": passMark,
        "strict": strict,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
        "result_publish_time": resultPublishTime == null
            ? null
            : resultPublishTime!.toIso8601String(),
        "total_subject": totalSubject,
        "retry_limit": retryLimit,
        "total_questions": totalQuestions,
        "mcq_count": mcqCount,
        "result": result == null ? null : result!.toJson(),
        "subjects": subjects == null
            ? null
            : List<dynamic>.from(subjects!.map((x) => x)),
      };
}

class Result {
  Result({
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
  });

  int? total;
  int? correct;
  int? submitted;
  int? wrong;
  String? totalMark;
  String? positiveMark;
  String? negativeMark;
  String? obtainedMark;
  DateTime? startTime;
  DateTime? endTime;
  dynamic subjects;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        total: json["total"],
        correct: json["correct"],
        submitted: json["submitted"],
        wrong: json["wrong"],
        totalMark: json["total_mark"],
        positiveMark:
            json["positive_mark"],
        negativeMark:
            json["negative_mark"],
        obtainedMark:
            json["obtained_mark"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        subjects: json["subjects"],
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
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
        "subjects": subjects,
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
