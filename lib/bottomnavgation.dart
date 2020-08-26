import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Text(
      'State',
    ),
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