import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sql_pratice/bloc/todo_bloc.dart';
import 'package:sql_pratice/service/db_manager.dart';

import 'model/todo_model.dart';

final List<ToDoModel> datas = new List<int>.generate(10, (index) => index + 1)
    .map((e) => ToDoModel(
        id: null,
        whens: DateTime.now(),
        title: "Test $e",
        contents: "TestContents $e"))
    .toList();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoViewer(),
    );
  }
}

class ToDoViewer extends StatelessWidget {
  final ToDoBloc bloc = ToDoBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestApp"),
        centerTitle: true,
      ),
      body: makeList(),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              bloc.deleteAll();
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              bloc.addTodo(datas[Random().nextInt(datas.length)]);
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  makeList() {
    return StreamBuilder<List<ToDoModel>>(
      stream: bloc.todo,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, idx) {
              final item = snapshot.data[idx];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  bloc.deleteTodo(item.id);
                },
                child: Center(
                  child: Text(item.title),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
