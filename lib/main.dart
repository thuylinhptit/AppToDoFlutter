
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'todo_task.dart';
import 'bottomnavgation.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  runApp(
      ChangeNotifierProvider<TodoTasks>(
        create: (context)  {
        return TodoTasks();
      },
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    )
  );
}

