import 'package:apptodo_flutter/task.dart';
import 'package:apptodo_flutter/todo_task.dart';
import 'package:apptodo_flutter/add_task.dart';
import 'package:apptodo_flutter/list_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';


class HomeScreen extends StatefulWidget{
  @override
  _HomeScreen createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return  Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('App To Do', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600 , color: Colors.white),),
                backgroundColor: Colors.lightBlueAccent,
                actions: <Widget> [
                  Consumer<TodoTasks>(
                    builder: (context, model, _) {
                      return PopupMenuButton<Choice>(
                        onSelected: (Choice choice) {
                          _select(choice, context);
                        },
                        icon: Icon(Icons.menu),
                        itemBuilder: (BuildContext context) {
                          return choices.map((Choice choice) {
                            var color = Colors.black87;
                            if( choice.index == 1 && model.status == TodoStatus.allTasks
                                || choice.index == 2 && model.status == TodoStatus.incompleteTasks
                                || choice.index == 3 && model.status == TodoStatus.completedtask
                            ) {
                              color= Colors.blue;
                            }
                            return PopupMenuItem<Choice>(
                                value: choice,
                                child: Text(choice.title, style: TextStyle( color:  color), ));
                          }).toList();
                        },
                      );
                    },
                  ),

                  PopupMenuButton<ClickAll>(
                    onSelected: (ClickAll clickAll) {
                      selectClickAll(clickAll, context);
                    },
                    icon: Icon(Icons.more_horiz),
                    itemBuilder: (BuildContext context) {
                      return listClickAll.map((ClickAll clickAll) {
                        return PopupMenuItem<ClickAll>(
                          value: clickAll,
                          child: Text(clickAll.title),
                        );
                      }).toList();
                    },

                  ),
                ],
              ),
              body: Consumer<TodoTasks> (
                  builder: (context, model, _) {
                    return  ListTask( listTask: model.tasks,);
                  }
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.lightBlueAccent,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute( builder: (context) => AddTask()) );
                  },
                ),
              ),
            ),
          ],
        );
  }

  void _select(Choice choice, BuildContext context) {
    Provider.of<TodoTasks>(context, listen: false).choiceStatus(choice);
  }

  void selectClickAll (ClickAll clickAll, BuildContext context){
    var todoProvider =  Provider.of<TodoTasks>( context, listen: false);
    if( clickAll.index == 1 ){
      todoProvider.fullDone();
    }
    else{
      todoProvider.fullDelete();
    }
  }

}

class Choice {
  const Choice({this.title, this.index});
  final String title;
  final int  index;
}

const List <Choice> choices = const <Choice>[
  const Choice(title: 'All Tasks', index: 1),
  const Choice(title: 'Incomplete Tasks', index: 2),
  const Choice(title: 'Completed Tasks', index: 3),
];

class ClickAll{
  const ClickAll({this.title, this.index});
  final String title;
  final int index;
}

const List <ClickAll> listClickAll = const<ClickAll>[
  const ClickAll(title: 'All Done', index: 1),
  const ClickAll(title: 'All Delete', index: 2)
];
