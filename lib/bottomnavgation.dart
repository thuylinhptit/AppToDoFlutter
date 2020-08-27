import 'package:apptodo_flutter/Todo_Tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class BottomNavigation extends StatefulWidget{

  @override
  _BottomNavigaton createState() => _BottomNavigaton();

}

class _BottomNavigaton extends State<BottomNavigation>{
  var _selectedIndex = 0;
   List<Widget> _widgetOptions = <Widget>[
    Center(
        child: HomeScreen(),
    ),
    Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stats', style: TextStyle(fontSize: 25),),
        ),
        body: Center(
          child: Consumer<TodoTasks>(

            builder:(context, model, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Completed Tasks'
                ),
                Text(
                  '${model.countComplete()}'
                ),
                Text(
                  'Incomplete Tasks'
                ),
                Text(
                    '${model.countIncomplete()}'
                )
              ],
            ),
          ),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: _widgetOptions.elementAt(_selectedIndex)
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text('Todos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back),
                title: Text('Stats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          backgroundColor: Colors.black87,
          onTap: _onTapItem,
        ),
    );

  }

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}