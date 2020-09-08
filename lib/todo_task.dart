import 'dart:collection';
import 'package:apptodo_flutter/task.dart';
import 'package:apptodo_flutter/database.dart';
import 'package:apptodo_flutter/home_screen.dart';
import 'package:flutter/cupertino.dart';

enum TodoStatus { allTasks, incompleteTasks, completedtask, fullDelete }

class TodoTasks extends ChangeNotifier {
  final List<Task> _tasks = [];
  final List<Task> _history = [];
  TodoStatus status = TodoStatus.allTasks;

  var db = DatabaseHelper();

  TodoTasks() {
    db.queryAll().then((value) {
      _tasks.addAll(value);
      _history.addAll(value);
      notifyListeners();
    });
  }

  UnmodifiableListView<Task> get tasks =>
      UnmodifiableListView(status == TodoStatus.allTasks
          ? _tasks
          : status == TodoStatus.completedtask
              ? _tasks.where((element) => element.isdone)
              : _tasks.where((element) => !element.isdone));

  UnmodifiableListView<Task> get history =>
      UnmodifiableListView(status == TodoStatus.allTasks
          ? _history
          : status == TodoStatus.completedtask
          ? _history
          : _history);

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
    var newTask  = await db.insertTask(task);
    _tasks.add(newTask);
    _history.add(newTask);
    notifyListeners();
  }

  Future<void> editTask(int index, Task task) async {
    _tasks[index] = task;
    _history[index] = task;
    await db.update(task);
    notifyListeners();
  }



  Future<void> toggleTodo(Task task) async {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    //_history[taskIndex].toggleCompleted();
    await db.update(task);
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
      _history[i].isdone = true;
      await db.update(_tasks[i]);
    }
    notifyListeners();
  }

  void fullDelete() {
    for( int i=0 ; i < _tasks.length ; i++){
      db.delete(_tasks[i]);
      _tasks.removeAt(i);
      notifyListeners();
    }
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
    db.delete(_tasks[index]);
    _tasks.removeAt(index);
    notifyListeners();
  }
}
