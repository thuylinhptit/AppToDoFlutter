import 'package:flutter/cupertino.dart';

class Task{
  String title;
  bool isdone;
  Task({@required this.title, this.isdone = false });
  void toggleCompleted() {
    isdone = !isdone;
  }

}