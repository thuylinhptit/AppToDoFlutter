import 'dart:collection';
import 'package:apptodo_flutter/Task.dart';
import 'package:apptodo_flutter/database.dart';
import 'package:apptodo_flutter/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TodoStatus { allTasks, incompleteTasks, completedtask, fullDelete }

class TodoTasks extends ChangeNotifier {
  final List<Task> _tasks = [];
  final List<Task> _history = [];
  TodoStatus status = TodoStatus.allTasks;

  // SharedPreferences prefs;
  var db = DatabaseHelper();

//  TodoTasks() {
//     SharedPreferences.getInstance().then((value) {
//      prefs = value;
//      String json =  prefs.getString("history");
//      if(json != null) {
//        _history.addAll(taskFromJson(json));
//        _tasks.addAll(taskFromJson(json));
//        notifyListeners();
//      }
//    });
//  }

  TodoTasks() {
    db.queryAll().then((value) {
      _tasks.addAll(value);
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

  Future<void> addTask(Task task) async {
//    _history.add(task);
    var newTask  = await db.insertTask(task);
    _tasks.add(newTask);
    //   prefs.setString("history",taskToJson(_tasks));
    // prefs.setString("history",taskToJson(_history));
    notifyListeners();
  }

  Future<void> editTask(int index, Task task) async {
    _tasks[index] = task;
//    _history[index] = task;
    await db.update(task);
    notifyListeners();
    // prefs.setString("history",taskToJson(_tasks));
    //  prefs.setString("history",taskToJson(_history));

  }

  void toggleTodo(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    //  _history[taskIndex].toggleCompleted();
    //  prefs.setString("history",taskToJson(_tasks));
    //  prefs.setString("history",taskToJson(_history));
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

  void fullDone() {
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].isdone = true;
//      _history[i].isdone = true;
    }
    // prefs.setString("history",taskToJson(_tasks));
    // prefs.setString("history",taskToJson(_history));
    notifyListeners();
  }

  void fullDelete() {
    _tasks.clear();
    //  prefs.clear();
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

  void Delete(int index) {
    // prefs.setString("history",taskToJson(_tasks));
    db.delete(_tasks[index]);
    _tasks.removeAt(index);
    notifyListeners();
  }
}
