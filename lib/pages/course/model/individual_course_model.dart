// To parse this JSON data, do
//
//     final individualCourseModel = individualCourseModelFromJson(jsonString);

import 'dart:convert';

IndividualCourseModel individualCourseModelFromJson(String str) =>
    IndividualCourseModel.fromJson(json.decode(str));

String individualCourseModelToJson(IndividualCourseModel data) =>
    json.encode(data.toJson());

class IndividualCourseModel {
  IndividualCourseModel({
    this.data,
  });

  IndividualCourseData? data;

  factory IndividualCourseModel.fromJson(Map<String, dynamic> json) =>
      IndividualCourseModel(
        data: json["data"] == null
            ? null
            : IndividualCourseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class IndividualCourseData {
  IndividualCourseData({
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
    this.sections,
    this.categories,
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
    this.reviews,
    this.users,
    this.faqs,
  });

  int? id;
  int? createdBy;
  String? title;
  String? slug;
  String? video;
  String? photo;
  dynamic subtitle;
  dynamic description;
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
  String? subscriptionStatus;
  List<dynamic>? coupons;
  List<Section>? sections;
  List<Category>? categories;
  bool? requireGuardiansPhone;
  dynamic rating;
  dynamic usersCount;
  dynamic fakeUserCount;
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
  List<Review>? reviews;
  List<User>? users;
  List<Faq>? faqs;

  factory IndividualCourseData.fromJson(Map<String, dynamic> json) =>
      IndividualCourseData(
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
        discountedPrice: json["discounted_price"],
        approved: json["approved"],
        active: json["active"],
        courseFeatures: json["courseFeatures"] == null
            ? null
            : List<dynamic>.from(json["courseFeatures"].map((x) => x)),
        subscriptionStatus: json["subscription_status"],
        coupons: json["coupons"] == null
            ? null
            : List<dynamic>.from(json["coupons"].map((x) => x)),
        sections: json["sections"] == null
            ? null
            : List<Section>.from(
                json["sections"].map((x) => Section.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        requireGuardiansPhone: json["require_guardians_phone"],
        rating: json["rating"],
        usersCount: json["users_count"],
        fakeUserCount: json["fake_user_count"],
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
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        users: json["users"] == null
            ? null
            : List<User>.from(json["users"].map((x) => User.fromJson(x))),
        faqs: json["faqs"] == null
            ? null
            : List<Faq>.from(json["faqs"].map((x) => Faq.fromJson(x))),
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
        "sections": sections == null
            ? null
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "require_guardians_phone": requireGuardiansPhone,
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
        "reviews": reviews == null
            ? null
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "faqs": faqs == null
            ? null
            : List<dynamic>.from(faqs!.map((x) => x.toJson())),
      };
}

class Faq {
  Faq({
    this.id,
    this.question,
    this.answer,
  });

  int? id;
  String? question;
  String? answer;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
      };
}

class Category {
  Category({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.photo,
    this.description,
    this.order,
    this.active,
    this.featured,
    this.children,
    this.childrenCount,
  });

  int? id;
  int? parentId;
  String? name;
  String? slug;
  String? photo;
  dynamic description;
  dynamic order;
  bool? active;
  bool? featured;
  List<dynamic>? children;
  int? childrenCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"],
        description: json["description"],
        order: json["order"],
        active: json["active"],
        featured: json["featured"],
        children: json["children"] == null
            ? null
            : List<dynamic>.from(json["children"].map((x) => x)),
        childrenCount: json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "slug": slug,
        "photo": photo,
        "description": description,
        "order": order,
        "active": active,
        "featured": featured,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
        "children_count": childrenCount,
      };
}

class Review {
  Review({
    this.id,
    this.userId,
    this.rating,
    this.title,
    this.body,
    this.photo,
    this.user,
  });

  int? id;
  int? userId;
  int? rating;
  dynamic title;
  String? body;
  dynamic photo;
  User? user;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        rating: json["rating"],
        title: json["title"],
        body: json["body"],
        photo: json["photo"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "rating": rating,
        "title": title,
        "body": body,
        "photo": photo,
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
  dynamic username;
  String? photo;
  dynamic phone;
  dynamic email;
  dynamic type;
  dynamic gender;
  String? dob;
  dynamic affiliation;
  dynamic subject;
  dynamic guardiansPhone;
  dynamic currentInstitution;
  dynamic varsity;
  dynamic college;
  dynamic school;
  dynamic lastLoginTime;
  dynamic approved;
  dynamic active;
  dynamic secondTimer;
  List<String>? permissions;
  List<String>? roles;
  dynamic district;
  dynamic ref;
  dynamic phoneVerifiedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        photo: json["photo"] ??
            'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
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
        phoneVerifiedAt: json["phone_verified_at"],
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
        "current_institution": currentInstitution,
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
        "phone_verified_at": phoneVerifiedAt,
      };
}

class Section {
  Section({
    this.id,
    this.courseId,
    this.title,
    this.slug,
    this.photo,
    this.description,
    this.order,
    this.paid,
    this.active,
    this.availableAt,
    this.contents,
    this.children,
  });

  int? id;
  int? courseId;
  String? title;
  String? slug;
  dynamic photo;
  dynamic description;
  int? order;
  bool? paid;
  bool? active;
  DateTime? availableAt;
  List<Content>? contents;
  List<Section>? children;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        courseId: json["course_id"],
        title: json["title"],
        slug: json["slug"],
        photo: json["photo"],
        description: json["description"],
        order: json["order"],
        paid: json["paid"],
        active: json["active"],
        availableAt: json["available_at"] == null
            ? null
            : DateTime.parse(json["available_at"]),
        contents: json["contents"] == null
            ? null
            : List<Content>.from(
                json["contents"].map((x) => Content.fromJson(x))),
        children: json["children"] == null
            ? null
            : List<Section>.from(
                json["children"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "title": title,
        "slug": slug,
        "photo": photo,
        "description": description,
        "order": order,
        "paid": paid,
        "active": active,
        "available_at":
            availableAt == null ? null : availableAt!.toIso8601String(),
        "contents": contents == null
            ? null
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
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
    this.video,
    this.pdf,
    this.exam,
    this.testmoj,
    this.link,
    this.live,
    this.note,
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
  dynamic duration;
  dynamic photo;
  int? order;
  bool? canPreview;
  bool? paid;
  bool? active;
  DateTime? availableAt;
  bool? smsToAll;
  Video? video;
  Pdf? pdf;
  Exam? exam;
  Testmoj? testmoj;
  Link? link;
  Live? live;
  Note? note;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        contentableType: json["contentable_type"],
        contentableId: json["contentable_id"],
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
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        pdf: json["pdf"] == null ? null : Pdf.fromJson(json["pdf"]),
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
        testmoj:
            json["testmoj"] == null ? null : Testmoj.fromJson(json["testmoj"]),
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        live: json["live"] == null ? null : Live.fromJson(json["live"]),
        note: json["note"] == null ? null : Note.fromJson(json["note"]),
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
        "video": video == null ? null : video!.toJson(),
        "pdf": pdf == null ? null : pdf!.toJson(),
        "exam": exam == null ? null : exam!.toJson(),
        "testmoj": testmoj == null ? null : testmoj!.toJson(),
        "link": link == null ? null : link!.toJson(),
        "live": live == null ? null : live!.toJson(),
        "note": note == null ? null : note!.toJson(),
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
  dynamic totalSubject;
  int? retryLimit;
  int? totalQuestions;
  int? mcqCount;
  dynamic result;
  List<dynamic>? subjects;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        mode: json["mode"],
        duration: json["duration"],
        perQuestionMark: json["per_question_mark"],
        negativeMark: json["negative_mark"],
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
        totalSubject: json["total_subject"],
        retryLimit: json["retry_limit"],
        totalQuestions: json["total_questions"],
        mcqCount: json["mcq_count"],
        result: json["result"],
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
        "start_time": startTime == null ? null : startTime?.toIso8601String(),
        "end_time": endTime == null ? null : endTime?.toIso8601String(),
        "result_publish_time": resultPublishTime == null
            ? null
            : resultPublishTime?.toIso8601String(),
        "total_subject": totalSubject,
        "retry_limit": retryLimit,
        "total_questions": totalQuestions,
        "mcq_count": mcqCount,
        "result": result,
        "subjects": subjects,
      };
}

class Testmoj {
  Testmoj({
    this.id,
    this.createdBy,
    this.contentId,
    this.title,
    this.slug,
    this.examLink,
    this.resultLink,
    this.duration,
    this.description,
    this.startTime,
    this.resultPublishTime,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic createdBy;
  int? contentId;
  dynamic title;
  dynamic slug;
  String? examLink;
  String? resultLink;
  dynamic duration;
  dynamic description;
  DateTime? startTime;
  DateTime? resultPublishTime;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Testmoj.fromJson(Map<String, dynamic> json) => Testmoj(
        id: json["id"],
        createdBy: json["created_by"],
        contentId: json["content_id"],
        title: json["title"],
        slug: json["slug"],
        examLink: json["exam_link"],
        resultLink: json["result_link"],
        duration: json["duration"],
        description: json["description"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        resultPublishTime: json["result_publish_time"] == null
            ? null
            : DateTime.parse(json["result_publish_time"]),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "content_id": contentId,
        "title": title,
        "slug": slug,
        "exam_link": examLink,
        "result_link": resultLink,
        "duration": duration,
        "description": description,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "result_publish_time": resultPublishTime == null
            ? null
            : resultPublishTime!.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Pdf {
  Pdf({
    this.id,
    this.link,
    this.pdfImages,
    this.previewLink,
    this.downloadLink,
    this.source,
  });

  int? id;
  String? link;
  List<PdfImage>? pdfImages;
  dynamic previewLink;
  dynamic downloadLink;
  String? source;

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        id: json["id"],
        link: json["link"],
        pdfImages: json["pdfImages"] == null
            ? null
            : List<PdfImage>.from(
                json["pdfImages"].map((x) => PdfImage.fromJson(x))),
        previewLink: json["preview_link"],
        downloadLink: json["download_link"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "pdfImages": pdfImages == null
            ? null
            : List<dynamic>.from(pdfImages!.map((x) => x.toJson())),
        "preview_link": previewLink,
        "download_link": downloadLink,
        "source": source,
      };
}

class PdfImage {
  PdfImage({
    this.id,
    this.pdfId,
    this.photo,
  });

  int? id;
  int? pdfId;
  String? photo;

  factory PdfImage.fromJson(Map<String, dynamic> json) => PdfImage(
        id: json["id"],
        pdfId: json["pdf_id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pdf_id": pdfId,
        "photo": photo,
      };
}

class Video {
  Video({
    this.id,
    this.link,
    this.downloadLink,
    this.source,
  });

  int? id;
  String? link;
  dynamic downloadLink;
  String? source;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        link: json["link"],
        downloadLink: json["download_link"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "download_link": downloadLink,
        "source": source,
      };
}

class Link {
  Link({
    this.id,
    this.contentId,
    this.src,
  });

  int? id;
  int? contentId;
  dynamic src;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        contentId: json["content_id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_id": contentId,
        "src": src,
      };
}

class Live {
  Live({
    this.id,
    this.contentId,
    this.title,
    this.slug,
    this.startTime,
    this.endTime,
    this.link,
    this.source,
  });

  int? id;
  int? contentId;
  String? title;
  dynamic slug;
  DateTime? startTime;
  DateTime? endTime;
  String? link;
  String? source;

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        id: json["id"],
        contentId: json["content_id"],
        title: json["title"],
        slug: json["slug"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        link: json["link"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_id": contentId,
        "title": title,
        "slug": slug,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
        "link": link,
        "source": source,
      };
}

class Note {
  Note({
    this.id,
    this.body,
  });

  int? id;
  String? body;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
      };
}
