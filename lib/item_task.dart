import 'package:apptodo_flutter/Todo_Tasks.dart';
import 'package:apptodo_flutter/add_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'Task.dart';

class ItemTask extends StatelessWidget{
  final Task task;
  int index;
  ItemTask({@required this.task,@required this.index});

  @override
  Widget build(BuildContext context) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.black26,
            child: ListTile(
              leading: Checkbox(
                value: task.isdone,
                onChanged: (bool checked) {
                  Provider.of<TodoTasks>(context, listen: false).toggleTodo(task);
                },
              ),
              title: Text(
                task.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
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
        );
  }

  Future<bool> Delete(BuildContext context,  int index){
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
                Provider.of<TodoTasks>(context, listen: false).Delete(index);
                Navigator.of(context).pop(true);
              }
            )
          ],
        );
      }
    );
  }

}