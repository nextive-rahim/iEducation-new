import 'dart:convert';

class SettingsResponseModel {
  SettingsResponseModel({
    this.data,
  });

  List<SettingModel>? data;

  SettingsResponseModel copyWith({
    List<SettingModel>? data,
  }) =>
      SettingsResponseModel(
        data: data ?? this.data,
      );

  factory SettingsResponseModel.fromRawJson(String str) =>
      SettingsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingsResponseModel.fromJson(Map<String, dynamic> json) =>
      SettingsResponseModel(
        data: json["data"] == null
            ? null
            : List<SettingModel>.from(
                json["data"].map((x) => SettingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SettingModel {
  SettingModel({
    this.id,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  SettingModel copyWith({
    int? id,
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SettingModel(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SettingModel.fromRawJson(String str) =>
      SettingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        id: json["id"],
        key: json["key"] ?? '',
        value: json["value"] ?? '',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
