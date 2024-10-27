import 'package:todo_app/model/todo_model.dart';
import '../helper/repositary.dart';

class DataService {
  late Repository _repository;

  DataService() {
    _repository = Repository();
  }

  // Added from notes save file
  saveTodo(TodoModel todo) async {
    return await _repository.insertData(todo.toMap());
  }
  //Read all notes
  readAllData() async{
    return await _repository.readData();
  }
//edit
  updateTodo(TodoModel todo) async {
    return await _repository.updateData(todo.toMap());
  }

  deleteTodo(todoId) async {
    return await _repository.deleteData(todoId);
  }

}


