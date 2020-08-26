import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Todo_Tasks.dart';
import 'bottomnavgation.dart';
void main() {
  runApp(
      ChangeNotifierProvider<TodoTasks>(
        create: (context)  {
        return TodoTasks();
      },
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: BottomNavigation(),
      ),
    )
  );
}

