import 'dart:io';

import 'package:apptodo_flutter/Task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final nameDb = "Task.db";
  static final versionBb = 1;
  static final table = "mytable2";
  static final columnId = "_id";
  static final columnDone = 'isdone';
  static final columnContent = 'title';

  //// singleton
  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), nameDb),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $table ($columnContent TEXT , $columnDone TEXT);",
        );
      },
      version: 1,
    );
  }

  Future<Task> insertTask(Task task) async {
    final Database db = await database;
    await db.rawQuery("INSERT INTO $table ($columnContent, $columnDone)"
            " VALUES('${task.title}','${task.isdone ? '1' : '0'}');");
     var list =  List<Task>.from((await db
        .rawQuery("SELECT rowid, $columnContent, $columnDone FROM $table ORDER BY rowid DESC LIMIT 1"))
        .map((x) => Task.fromJson(x)));
    return list.first;
  }

  Future<List<Task>> queryAll() async {
    final Database db = await database;
    return List<Task>.from((await db
            .rawQuery("SELECT rowid, $columnContent, $columnDone FROM $table"))
        .map((x) => Task.fromJson(x)));
  }

  Future<void> update(Task task) async {
    final Database db = await database;
    return await db.rawQuery(
        "UPDATE $table SET $columnContent = '${task.title}', $columnDone = '${task.isdone ? '1' : '0'}'"
        " WHERE rowid = '${task.id}';");
  }

  Future<void> delete(Task task) async {
    final Database db = await database;
    return await db.rawQuery("DELETE FROM $table WHERE rowid = ?", [task.id]);
  }

  Future<void> deleteAll() async {
    final db = await database;
    db.delete(table);
  }

  Future<int> queryRowCount() async {
    final Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}
