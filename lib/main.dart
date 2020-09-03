import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Todo_Tasks.dart';
import 'bottomnavgation.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{


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

