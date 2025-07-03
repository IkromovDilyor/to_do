// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int id;
  String title;
  bool isDone;
  String userId;
  DateTime createdAt;
  String description;

  TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.userId,
    required this.createdAt,
    required this.description,
  });

  TaskModel copyWith({bool? isDone}) => TaskModel(
    id: id,
    title: title,
    isDone: isDone ?? this.isDone,
    userId: userId,
    createdAt: createdAt,
    description: description,
  );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["id"],
    title: json["title"],
    isDone: json["is_done"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "is_done": isDone,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "description": description,
  };
}
