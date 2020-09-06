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
          "CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnContent TEXT , $columnDone TEXT )",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    final Database db = await database;
    await db.insert(table, task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> queryAll() async {
    final Database db = await database;
    return List<Task>.from((await db.query(table)).map((x) => Task.fromJson(x)));
  }

  Future<void> update(Map<dynamic, dynamic> update) async {
    final Database db = await database;
    int id = update[columnId];
    return await db
        .update(table, update, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
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
