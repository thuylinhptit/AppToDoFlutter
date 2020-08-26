import 'dart:collection';
import 'package:apptodo_flutter/Task.dart';
import 'package:apptodo_flutter/home_screen.dart';
import 'package:flutter/cupertino.dart';

enum TodoStatus {
  allTasks, incompleteTasks, completedtask
}

class TodoTasks extends ChangeNotifier {
  final List <Task> _tasks = [];
  TodoStatus status = TodoStatus.allTasks;

  UnmodifiableListView <Task> get tasks => UnmodifiableListView(
      status == TodoStatus.allTasks ? _tasks :
      status == TodoStatus.completedtask ? _tasks.where((element) => element.isdone)
      : _tasks.where((element) => !element.isdone)
  );

  void addTask( Task task ){
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTodo(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void ChoiceStatus( Choice choice ){
    if( choice.index == 1 ) status = TodoStatus.allTasks;
    else if( choice.index == 2 ) status = TodoStatus.incompleteTasks;
    else if( choice.index == 3 ) status = TodoStatus.completedtask;
    notifyListeners();
  }


}
