// To parse this JSON data, do
//
//     final individualExamModel = individualExamModelFromJson(jsonString);

import 'dart:convert';

IndividualExamModel individualExamModelFromJson(String str) =>
    IndividualExamModel.fromJson(json.decode(str));

String individualExamModelToJson(IndividualExamModel data) =>
    json.encode(data.toJson());

class IndividualExamModel {
  IndividualExamModel({
    this.data,
  });

  IndividualExamData? data;

  factory IndividualExamModel.fromJson(Map<String, dynamic> json) =>
      IndividualExamModel(
        data: json["data"] == null
            ? null
            : IndividualExamData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class IndividualExamData {
  IndividualExamData({
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

  factory IndividualExamData.fromJson(Map<String, dynamic> json) =>
      IndividualExamData(
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
  dynamic totalSubject;
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
        totalSubject: json["total_subject"],
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
