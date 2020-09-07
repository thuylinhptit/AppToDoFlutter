import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  int id;
  String title;
  bool isdone;

  Task({@required this.title, this.isdone = false, this.id});

  factory Task.fromJson(Map<dynamic, dynamic> json) => Task(
        id: json['rowid'],
        title: json["title"],
        isdone: json["isdone"] == '1',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "isdone": isdone ? '1' : '0',
      };

  void toggleCompleted() {
    isdone = !isdone;
  }

  void setId(int id) {
    id = this.id;
  }
}
