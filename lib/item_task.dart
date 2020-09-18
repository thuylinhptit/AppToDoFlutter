import 'dart:math';

import 'package:apptodo_flutter/todo_task.dart';
import 'package:apptodo_flutter/add_task.dart';
import 'package:apptodo_flutter/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'task.dart';

@HiveType(typeId: 0)
class MyListTask extends HiveObject {
  @HiveField(0)
  String list;

  MyListTask({@required this.list});
}

class ItemTask extends StatelessWidget{
  final Task task;
  int index;
  ItemTask({@required this.task,@required this.index});

  @override
  Widget build(BuildContext context) {
     return Padding(
          padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isdone,
                      onChanged: (bool checked) {
                        Provider.of<TodoTasks>(context, listen: false).toggleTodo(task);
                      },
                    ),
                    title: Text(
                      task.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),

                ),
            actions: <Widget> [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.redAccent,
                icon: Icons.delete,
                onTap: () => Delete(context, index),
              ),
              IconSlideAction(
                caption: 'Edit',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTask(task: task, index: index,),
                fullscreenDialog: true,)),
                closeOnTap: false,
              ),
            ],
          ),
        );
  }

  Future<bool> Delete(BuildContext context,  int index){
    final taskProvider = Provider.of<TodoTasks>(context, listen: false);

    return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text('Delete'),
              onPressed: () {
                task.isDelete  = true;
                taskProvider.delete(task.id);
                Navigator.of(context).pop(true);
              }
            )
          ],
        );
      }
    );
  }


}