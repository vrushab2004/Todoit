import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoit/model/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String todoTable = 'todo_table';
  String colId = 'id';
  String colTodoText = 'todoText';
  String colIsDone = 'isDone';

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbDir = await getDatabasesPath();
    final dbPath = join(dbDir, 'todo.db');

    final todoDb = await openDatabase(dbPath, version: 1, onCreate: _createDb);
    return todoDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $todoTable($colId TEXT PRIMARY KEY, $colTodoText TEXT, $colIsDone INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    final db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(todoTable);
    return result;
  }

  Future<int> insertTodo(ToDo todo) async {
    final db = await this.db;
    final int result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  Future<int> updateTodo(ToDo todo) async {
    final db = await this.db;
    final int result = await db.update(
      todoTable,
      todo.toMap(),
      where: '$colId = ?',
      whereArgs: [todo.id],
    );
    return result;
  }

  Future<int> deleteTodo(String id) async {
    final db = await this.db;
    final int result = await db.delete(
      todoTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> deleteAllTodos() async {
    final db = await this.db;
    final int result = await db.delete(todoTable);
    return result;
  }

  Future<List<ToDo>> getTodoList() async {
    final List<Map<String, dynamic>> todoMapList = await getTodoMapList();
    final List<ToDo> todoList = [];
    todoMapList.forEach((todoMap) {
      todoList.add(ToDo.fromMap(todoMap));
    });
    return todoList;
  }
}