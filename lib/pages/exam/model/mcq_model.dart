// To parse this JSON data, do
//
//     final mcqModel = mcqModelFromJson(jsonString);

import 'dart:convert';

McqModel mcqModelFromJson(String str) => McqModel.fromJson(json.decode(str));

String mcqModelToJson(McqModel data) => json.encode(data.toJson());

class McqModel {
  McqModel({
    this.data,
  });

  MCQModelData? data;

  factory McqModel.fromJson(Map<String, dynamic> json) => McqModel(
        data: json["data"] == null ? null : MCQModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class MCQModelData {
  MCQModelData({
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
    this.mcqs,
    this.mcqCount,
    this.result,
    this.subjects,
  });

  int? id;
  String? mode;
  int? duration;
  String? perQuestionMark;
  dynamic negativeMark;
  dynamic passMark;
  bool? strict;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? resultPublishTime;
  dynamic totalSubject;
  int? retryLimit;
  int? totalQuestions;
  List<Mcq>? mcqs;
  int? mcqCount;
  Result? result;
  List<dynamic>? subjects;

  factory MCQModelData.fromJson(Map<String, dynamic> json) => MCQModelData(
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
        totalQuestions:
            json["total_questions"],
        mcqs: json["mcqs"] == null
            ? null
            : List<Mcq>.from(json["mcqs"].map((x) => Mcq.fromJson(x))),
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
        "negative_mark":  negativeMark,
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
        "mcqs": mcqs == null
            ? null
            : List<dynamic>.from(mcqs!.map((x) => x.toJson())),
        "mcq_count": mcqCount,
        "result": result,
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
    this.createdAt,
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
  DateTime? createdAt;

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}

class Mcq {
  Mcq({
    this.id,
    this.mcqStoreId,
    this.question,
    this.questionPhoto,
    this.questionDescription,
    this.a,
    this.b,
    this.c,
    this.d,
    this.e,
    this.f,
    this.g,
    this.h,
    this.i,
    this.j,
    this.answer,
    this.answerPhoto,
    this.answerDescription,
    this.verified,
    this.difficultyLevel,
    this.active,
    this.userAnswer,
  });

  int? id;
  int? mcqStoreId;
  String? question;
  dynamic questionPhoto;
  dynamic questionDescription;
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  dynamic f;
  dynamic g;
  dynamic h;
  dynamic i;
  dynamic j;
  String? answer;
  dynamic answerPhoto;
  dynamic answerDescription;
  dynamic verified;
  dynamic difficultyLevel;
  bool? active;
  dynamic userAnswer;

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        id: json["id"],
        mcqStoreId: json["mcq_store_id"],
        question: json["question"],
        questionPhoto: json["question_photo"],
        questionDescription: json["question_description"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        e: json["e"],
        f: json["f"],
        g: json["g"],
        h: json["h"],
        i: json["i"],
        j: json["j"],
        answer: json["answer"],
        answerPhoto: json["answer_photo"],
        answerDescription: json["answer_description"],
        verified: json["verified"],
        difficultyLevel: json["difficulty_level"],
        active: json["active"],
        userAnswer: json["user_answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mcq_store_id": mcqStoreId,
        "question": question,
        "question_photo": questionPhoto,
        "question_description": questionDescription,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "e": e,
        "f": f,
        "g": g,
        "h": h,
        "i": i,
        "j": j,
        "answer": answer,
        "answer_photo": answerPhoto,
        "answer_description": answerDescription,
        "verified": verified,
        "difficulty_level": difficultyLevel,
        "active": active,
        "user_answer": userAnswer,
      };
}
