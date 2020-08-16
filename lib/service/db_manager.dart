import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_pratice/model/todo_model.dart';

final String tableName = "todo";

class DbManager {
  DbManager._();

  static final DbManager _db = DbManager._();
  factory DbManager() => _db;

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    //반환형 생략 ( 자동으로 맞춰줌 )
    String path = join(await getDatabasesPath(), 'todo_database.db');
    print(path);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          '''create table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,whens BIGINT,title TEXT,contents TEXT);''');
    }, onUpgrade: (db, oldv, newv) {}); // Migration 이 ㅣ필요하다면 다음을 구현하세요!
  }

  createData(ToDoModel model) async {
    final db = await database;
    var result = await db.insert(tableName, model.toMap());
    return result;
  }

  getData(int id) async {
    final db = await database;
    var result =
        await db.rawQuery('select * from $tableName where id = ?', [id]);

    if (result.isEmpty) return Null;

    var temp = result.first;
    return ToDoModel.fromMap(temp);
  }

  Future<List<ToDoModel>> getAllData() async {
    final db = await database;
    var result = await db.rawQuery('select * from $tableName');
    List<ToDoModel> list = result.isNotEmpty
        ? result.map((e) => ToDoModel.fromMap(e)).toList()
        : [];
    return list;
  }

  deleteData(int id) async {
    final db = await database;
    var result =
        await db.rawDelete('delete from $tableName where id = ?', [id]);
    return result;
  }

  deleteAllData() async {
    final db = await database;
    db.rawDelete('delete from $tableName');
  }

  updateData(ToDoModel model) async {
    final db = await database;
    var result = db.update(tableName, model.toMap());
    return result;
  }
}
