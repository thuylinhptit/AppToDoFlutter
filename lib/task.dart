import 'package:flutter/cupertino.dart';

import 'dart:convert';

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Task {
  String id;
  String title;
  bool isdone;
  bool isDelete;

  Task({this.id, this.title, this.isdone, this.isDelete});

  Task.fromMap(Map snapshot,String id) :
        id = id ?? '',
        title = snapshot['title'] ?? '',
        isdone = snapshot['isdone'] ?? '',
        isDelete = snapshot['isDelete'] ?? '';

  toJson() {
    return {
      "title": title,
      "isdone": isdone,
      "isDelete": isDelete,
    };
  }
  void toggleCompleted() {
    isdone = !isdone;
  }
}
