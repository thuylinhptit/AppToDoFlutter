import 'package:apptodo_flutter/Todo_Tasks.dart';
import 'package:apptodo_flutter/add_task.dart';
import 'package:apptodo_flutter/list_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget{
  @override
  _HomeScreen createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen> {
  ClickAll _selectClickAll = listClickAll[0];
  TodoTasks _todoTasksProvider;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            title: Text('App To Do', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600 , color: Colors.white),),
            backgroundColor: Colors.black54,
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
                          };
                          return PopupMenuItem<Choice>(
                              value: choice,
                              child: Text(choice.title, style: TextStyle( color:  color), ));
                        }).toList();
                      },
                    );
                  },
                ),

              PopupMenuButton<ClickAll>(
                onSelected: selectClickAll,
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
          },
        ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute( builder: (context) => AddTask()) );
              },
            ),
          ),
        ),
    );
  }

  void _select(Choice choice, BuildContext context) {
    Provider.of<TodoTasks>(context, listen: false).ChoiceStatus(choice);
  }

  void selectClickAll (ClickAll clickAll){
//    setState(() {
//      _selectClickAll = clickAll;
//    });

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
  const ClickAll({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List <ClickAll> listClickAll = const<ClickAll>[
  const ClickAll(title: 'All Done', icon:  Icons.done_all),
  const ClickAll(title: 'All Delete', icon: Icons.delete_forever)
];

//class ClickAllCard extends StatelessWidget {
//  const ClickAllCard({Key key, this.clickAll}) : super(key: key);
//
//  final ClickAll clickAll;
//
//  @override
//  Widget build(BuildContext context) {
//    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
//    return Card(
//      color: Colors.black26,
//      child: Center(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Icon(clickAll.icon, size: 128.0, color: textStyle.color),
//            Text(clickAll.title, style: textStyle),
//          ],
//        ),
//      ),
//    );
//  }
//}
