import 'dart:async';

import 'package:sql_pratice/model/todo_model.dart';
import 'package:sql_pratice/service/db_manager.dart';

class ToDoBloc {
  final _todoController = StreamController<List<ToDoModel>>.broadcast();

  get todo => _todoController.stream;

  ToDoBloc() {
    getAllTodo();
  }

  getAllTodo() async {
    _todoController.sink.add(await DbManager().getAllData());
  }

  addTodo(ToDoModel model) async {
    await DbManager().createData(model);
    getAllTodo();
  }

  deleteTodo(int id) async {
    await DbManager().deleteData(id);
    getAllTodo();
  }

  deleteAll() async {
    await DbManager().deleteAllData();
    getAllTodo();
  }

  dispose() {
    _todoController.close();
  }
}
