import 'dart:collection';
import 'package:apptodo_flutter/Task.dart';
import 'package:apptodo_flutter/home_screen.dart';
import 'package:flutter/cupertino.dart';

enum TodoStatus {
  allTasks,
  incompleteTasks,
  completedtask, fullDelete
}
class TodoTasks extends ChangeNotifier {
  final List <Task> _tasks = [];
  TodoStatus status = TodoStatus.allTasks;


  UnmodifiableListView <Task> get tasks => UnmodifiableListView(
      status == TodoStatus.allTasks ? _tasks :
      status == TodoStatus.completedtask ? _tasks.where((element) => element.isdone)
      : _tasks.where((element) => !element.isdone)
  );
  int countComplete(){
    int count = 0;
    for( int i = 0 ; i< _tasks.length ; i++ ){
      if( _tasks[i].isdone == true ){
        count ++;
      }
    }
    return count;
  }

  int countIncomplete(){
    return _tasks.length - countComplete();

  }

  void addTask( Task task ){
    _tasks.add(task);
    notifyListeners();
  }

  void editTask( int index , Task task ){
   _tasks[index] = task;
   notifyListeners();
  }

  void toggleTodo(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void choiceStatus( Choice choice ){
    if( choice.index == 1 ) status = TodoStatus.allTasks;
    else if( choice.index == 2 ) status = TodoStatus.incompleteTasks;
    else if( choice.index == 3 ) status = TodoStatus.completedtask;
    notifyListeners();
  }


  void fullDone ( ){
    for( int i=0; i<_tasks.length ; i++ ){
      _tasks[i].isdone = true;
    }
    notifyListeners();
  }

  void fullDelete ( ){
    _tasks.clear();
    notifyListeners();
  }

  void choiceClickAll ( ClickAll clickAll ){
    Task task;
    if( clickAll.index == 1 ) {
      if( task.isdone == false ){
        task.isdone = true;

      }
      status = TodoStatus.allTasks;
    }
    if( clickAll.index == 2 ) {
      for( int i=0; i<_tasks.length; i++ ){
        _tasks.removeAt(i);
      }
      status = TodoStatus.fullDelete;
    }
    notifyListeners();
  }

  void Delete( int index ){
    _tasks.removeAt(index);
    notifyListeners();
  }

}

