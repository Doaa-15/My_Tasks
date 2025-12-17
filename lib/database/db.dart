import 'package:add_tasks/model/model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;
  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initdb();
    return _database!;
  }

  Future initdb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "tasks.db"); // create folder for database
    return await openDatabase(path, version: 1, onCreate: _onCreate); // if database not exist in folder => oncreate
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE Table tasks(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task TEXT,
    description TEXT

      )
      ''');
  }

  // insert
  Future<int> insertTask(Model model) async {
    Database db = await instance.db;
    return await db.insert("tasks", model.toMap());
  }

  //read
  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database db = await instance.db;
    return await db.query("tasks");
  }

  //update
  Future<int> UpdateTask(Model model) async {
    Database db = await instance.db;
    return await db.update(
      "tasks",
      model.toMap(),
      where: 'id=?',
      whereArgs: [model.id],
    );
  }

  ///delete
  Future<int> deleteTask(Model model) async {
    Database db = await instance.db;
   return await db.delete("tasks", where: 'id=?', whereArgs: [model.id]);

  }

  //get
Future<List<Model>> getTask() async {
  Database db = await instance.db;
  List<Map<String, dynamic>> tasks = await db.query("tasks");
  return tasks.map((e) => Model.fromJson(e)).toList();
}

 
}
