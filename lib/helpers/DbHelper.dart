import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {

  static Future<sql.Database> datatbase() async{
      final dbPath = await sql.getDatabasesPath();
      return sql.openDatabase(path.join(dbPath, 'Places.db',), onCreate: (db, version) {

        return db.execute('CREATE TABLE user_data(id TEXT PRIMARY KEY, title TEXT, image TEXT, address TEXT, latitude REAL, longitude REAL)');

      }, version: 1);

  }
  
  static Future<void> insert(String table, Map<String,Object> data) async{

      final db = await DbHelper.datatbase();
      db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace,);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async{
    final db = await DbHelper.datatbase();
    return db.query(table);
  }

}