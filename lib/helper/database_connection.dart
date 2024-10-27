import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{
  Future <Database> setDatabase()async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,'todo_model');
    var database = await openDatabase(path,version: 1,onCreate: _createDatabase);
    return database;
  }


  Future <void> _createDatabase(Database database ,int version) async{
    String sql = "CREATE TABLE todo_model (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,category TEXT,priority TEXT,createdAt TEXT,isCompleted int );";
    await database.execute(sql);
  }

}
