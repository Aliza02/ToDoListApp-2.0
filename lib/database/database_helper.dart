import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolistapp/model/task.dart';

class DatabaseHelper {
  static const dbName = 'tasks.db';
  static const dbVersion = 1;
  static const toDoTableName = 'toDoTable';
  static const columnId = 'id';
  static const task = 'Task';
  static const status = 'status';
  static late Database _database;

  static Future<Database> get database async {
    _database = await initDatabase();
    return _database;
  }

  static initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, dbName);
    return await openDatabase(
      path, version: dbVersion, onCreate: _onCreate,
      // onOpen: queryAllRows,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE $toDoTableName 
   ( $columnId INTEGER PRIMARY KEY,
    $task TEXT NOT NULL,
    $status TEXT NOT NULL)
    """);
  }

  Future<int> insert(Map<String, String> data) async {
    var connection = await database;
    return await connection.insert(toDoTableName, data);
  }

  static Future<List<Task>> queryAllRows() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(toDoTableName);
    return List.generate(maps.length, (index) {
      return Task(
          maps[index]['Task'], maps[index]['id'], maps[index]['status']);
    });
  }

  static Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(toDoTableName,  where: '$columnId = ?', whereArgs: [id]);
  }
}
