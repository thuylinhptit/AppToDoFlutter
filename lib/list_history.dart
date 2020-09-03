import 'package:apptodo_flutter/Task.dart';
import 'package:flutter/cupertino.dart';

import 'item_task.dart';

class ListHistory extends StatelessWidget{
  final List <Task> listHistory ;
  const ListHistory({@required this.listHistory});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getTask(),
    );
  }
  List<Widget> getTask(){
    var currentIndex = -1;
    return listHistory.map((e) {
      currentIndex += 1;
      return  ItemTask(task: e,index: currentIndex, );
    }).toList();
  }

}