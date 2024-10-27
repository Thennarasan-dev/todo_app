import 'package:sqflite/sqflite.dart';
import 'database_connection.dart';

class Repository {
  //previous class object in database_connection file and making instance
  late final DatabaseConnection _databaseConnection;
  final table = 'todo_model';
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }




  insertData(Map<String, dynamic> map) async {
    var connection = await database;
    return await connection?.insert(table, map);
  }

  readData() async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Read single record by id
  readDataById(itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  updateCompletion(int id,int isCompleted)async{
    var connection = await database;
    return await connection?.update(table,{'isCompleted' : isCompleted}, where: 'id =?',whereArgs: [id]);
  }

  deleteData(id) async {
    var connection = await database;
    return await connection?.rawDelete(
      'DELETE FROM $table WHERE id = ?',
      [id],
    );
  }
}
