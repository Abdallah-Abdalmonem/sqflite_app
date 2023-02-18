import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get getInstance async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print('Database is upgraded!!!');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "tasks"(id INTEGER NOT NULL PRIMARY KEY ,
                    Name TEXT NOT NULL , Notes TEXT NOT NULL 
  )
  ''');
    insertData(name: 'Name', note: 'note');
    print('Database is created!!!');
  }

  readData() async {
    Database? mydb = await getInstance;
    List<Map> response = await mydb!.rawQuery('SELECT * FROM "tasks"');
    return response;
  }

  insertData({required String name, required String note}) async {
    Database? mydb = await getInstance;
    int response = await mydb!.rawInsert('''
  INSERT INTO tasks(Name, Notes) VALUES("$name", "$note")
  ''');
    return response;
  }

  updateData({String? name, String? notes, required int id}) async {
    Database? mydb = await getInstance;
    int response = await mydb!.rawUpdate(
        'UPDATE tasks SET Name = ?, Notes = ? WHERE id = ?',
        ['$name', '$notes', '$id']);
    return response;
  }

  deleteData({required int id}) async {
    Database? mydb = await getInstance;
    int response = await mydb!.rawDelete('DELETE FROM "tasks" WHERE id = $id');
    print('the item number $id is deleted');
    return response;
  }
}
