import 'package:apptodo_flutter/todo_task.dart';
import 'package:apptodo_flutter/list_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History', style: TextStyle( fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
//      body: Consumer<TodoTasks>(
//        builder: (context, model, _ ){
//          return ListHistory( listHistory: model.history,);
//        },
//      ),
    );
  }

}