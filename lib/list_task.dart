import 'package:apptodo_flutter/task.dart';
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
    var currentIndex = -1;
    return listTask.map((e) {
      currentIndex += 1;
    return  ItemTask(task: e,index: currentIndex, );
    }).toList();
  }

}