import 'dart:collection';
import 'package:apptodo_flutter/api.dart';
import 'package:apptodo_flutter/locator.dart';
import 'package:apptodo_flutter/task.dart';
import 'package:apptodo_flutter/database.dart';
import 'package:apptodo_flutter/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

enum TodoStatus { allTasks, incompleteTasks, completedtask, fullDelete }

class TodoTasks extends ChangeNotifier {
  List<Task> _tasks = [];
  TodoStatus status = TodoStatus.allTasks;
  Api _api = locator<Api>();

  Future<List<Task>> fetchTasks() async {
    var result = await _api.getData();
    var _tasks =
        result.docs.map((doc) => Task.fromMap(doc.data(), doc.id)).toList();
    return _tasks;
  }

  TodoTasks() {
    _api.streamData().listen((snapshot) {
      var tasks = snapshot.docs.map((doc) {
        return Task(
            id: doc.id,
            title: doc.data()["title"],
            isdone: doc.data()["isdone"]);
      });
      _tasks.clear();
      _tasks.addAll(tasks);
      notifyListeners();
    });
  }

  UnmodifiableListView<Task> get tasks =>
      UnmodifiableListView(status == TodoStatus.allTasks
          ? _tasks
          : status == TodoStatus.completedtask
              ? _tasks.where((element) => element.isdone)
              : _tasks.where((element) => !element.isdone));
  int countComplete() {
    int count = 0;
    for (int i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isdone == true) {
        count++;
      }
    }
    return count;
  }

  int countIncomplete() {
    return _tasks.length - countComplete();
  }

  Future addTask(Task task) async {
    await _api.addTask(task.toJson());
  }

  Future updateTask(Task task, String id) async {
    await _api.updateTask(task.toJson(), id);
  }

  Future delete(String id) async {
    await _api.removeTask(id);
  }

  Stream<QuerySnapshot> fetchTaskAsStream() {
    return _api.streamData();
  }

  Future<void> toggleTodo(Task task) async {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    await _api.updateTask(task.toJson(), task.id);
    notifyListeners();
  }

  void choiceStatus(Choice choice) {
    if (choice.index == 1)
      status = TodoStatus.allTasks;
    else if (choice.index == 2)
      status = TodoStatus.incompleteTasks;
    else if (choice.index == 3) status = TodoStatus.completedtask;
    notifyListeners();
  }

  Future<void> fullDone() async {
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].isdone = true;
      await _api.updateTask(_tasks[i].toJson(), _tasks[i].id);
    }
    notifyListeners();
  }

  void fullDelete() async{
    for (int i = 0; i < _tasks.length; i++) {
       _api.removeTask(_tasks[i].id);
    }
    notifyListeners();
  }

  void choiceClickAll(ClickAll clickAll) {
    Task task;
    if (clickAll.index == 1) {
      if (task.isdone == false) {
        task.isdone = true;
      }
      status = TodoStatus.allTasks;
    }
    if (clickAll.index == 2) {
      for (int i = 0; i < _tasks.length; i++) {
        _tasks.removeAt(i);
      }
      status = TodoStatus.fullDelete;
    }
    notifyListeners();
  }
}
