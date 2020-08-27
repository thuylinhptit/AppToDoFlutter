import 'package:apptodo_flutter/Todo_Tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Task.dart';

class AddTask extends StatefulWidget{
  final Task task;
  final int index;

  AddTask({ this.task, this.index});
  @override
  _AddTask createState() => _AddTask();

}

class _AddTask extends State<AddTask>{
  final taskTextController = TextEditingController();
  bool statusDone = false;

  @override
  void initState() {
    super.initState();
    if( widget.task != null ){
      taskTextController.text=widget.task.title;
    }
  }

  @override
  void dispose() {
    taskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                    child: TextField(
                      controller: taskTextController,
                      decoration: InputDecoration(
                        labelText: 'Add Task'
                      ),),
                  ),
                  RaisedButton(
                    child: Text('Add'),
                    onPressed: onSubmit,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void onSubmit(){
    final String tasktext = taskTextController.text;
    final bool isdone = statusDone;
    var todoTaskProvider = Provider.of<TodoTasks>(context, listen: false);

    // Edit
    if( widget.task != null && widget.index != null ){
      todoTaskProvider.editTask(widget.index, Task(title: taskTextController.text, isdone: widget.task.isdone ));
      Navigator.pop(context);
      return;
    }
    //Add
    if (tasktext.isNotEmpty) {
       Task todo = Task(
        title: tasktext, isdone : isdone,
      );
      todoTaskProvider.addTask(todo);
      Navigator.pop(context);
      print('Done Add');
    }
  }

}