import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LiteDb {
  static Database? _db;

  // //
  // _LiteDb() {}

  Future<Database?> get getInstance async {
    if (_db == null) {
      _db = await instance();
      return _db;
    }
    return _db;
  }

  instance() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'lite.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
                  CREATE TABLE PERSON (id INTEGER AUTOINCREMENT PRIMARY KEY, name TEXT NOT NULL, age INTEGER);
                  CREATE TABLE ACCOUNT (id INTEGER AUTOINCREMENT PRIMARY KEY, PERSON_ID INTEGER NOT NULL, ACCOUNT INTEGER NOT NULL,VALUE REAL);
              ''');
    });

    print('text database has been created');
    return database;
  }

  inquiry(String sqlText) async {
    Database? db = await getInstance;

    // Get the records
    List<Map> list = await db!.rawQuery('SELECT * FROM $sqlText');
    return list;
  }

  insert(String sqlText) async {
    Database? db = await getInstance;

    // insert some record
    int count = await db!.rawInsert(sqlText);
    return count;
    // if return 0 is not insert
  }

  update(String sqlText) async {
    Database? db = await getInstance;

    // Update some record
    int count = await db!.rawUpdate(sqlText);
    return count;
    // if return 0 is not update
  }

  delete(String sqlText) async {
    Database? db = await getInstance;

    // Update some record
    int count = await db!.rawDelete(sqlText);
    return count;
    // if return 0 is not delete
  }
}
