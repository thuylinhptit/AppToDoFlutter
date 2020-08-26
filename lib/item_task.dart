import 'package:apptodo_flutter/Todo_Tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task.dart';

class ItemTask extends StatelessWidget{
  final Task task;
  ItemTask({@required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isdone,
        onChanged: (bool checked) {
          Provider.of<TodoTasks>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(
        task.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

}