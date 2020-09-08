import 'package:apptodo_flutter/task_history.dart';
import 'package:apptodo_flutter/todo_task.dart';
import 'package:apptodo_flutter/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task.dart';

class AddTask extends StatefulWidget {
  final Task task;
  final TaskHistory taskH;
  final int index;

  AddTask({this.task, this.index, this.taskH});

  @override
  _AddTask createState() => _AddTask();
}

final dbHelper = DatabaseHelper();

class _AddTask extends State<AddTask> {
  final taskTextController = TextEditingController();
  bool statusDone = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      taskTextController.text = widget.task.title;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Task'),
        backgroundColor: Colors.lightBlueAccent,
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
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(labelText: 'Add Todo'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: Text('Add'),
                      onPressed: onSubmit,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  void onSubmit() {
    final String tasktext = taskTextController.text;
    final bool isdone = statusDone;
    var todoTaskProvider = Provider.of<TodoTasks>(context, listen: false);

    // Edit
    if (widget.task != null && widget.index != null) {
      Task todo = Task(
          title: taskTextController.text,
          isdone: widget.task.isdone,
          id: widget.task.id);
      todoTaskProvider
          .editTask(widget.index, todo)
          .then((value) => Navigator.pop(context));
      return;
    }
    //Add
    if (tasktext.isNotEmpty) {
      Task todo = Task(
        title: tasktext,
        isdone: isdone,
      );
      todoTaskProvider.addTask(todo).then((value) {
        Navigator.pop(context);
        print('Done Add');
      });
    }
  }
}
