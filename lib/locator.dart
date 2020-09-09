import 'package:apptodo_flutter/api.dart';
import 'package:apptodo_flutter/todo_task.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Api>(() => Api('Task'));
  locator.registerLazySingleton<TodoTasks>(() => TodoTasks()) ;
}