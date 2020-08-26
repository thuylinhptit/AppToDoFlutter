import 'package:apptodo_flutter/Task.dart';
import 'package:flutter/cupertino.dart';

import 'item_task.dart';

class ListTask extends StatelessWidget{
  final List <Task> listTask ;
  const ListTask({@required this.listTask});
  @override
 Widget build(BuildContext context) {
    return ListView(
      children: getTask(),
    );
  }
  List<Widget> getTask(){
    return listTask.map((e) => ItemTask(task: e)).toList();
  }

}