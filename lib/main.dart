import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sql_pratice/db_manager.dart';
import 'package:sql_pratice/todo_model.dart';

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

class ToDoViewer extends StatefulWidget {
  @override
  _ToDoViewerState createState() => _ToDoViewerState();
}

class _ToDoViewerState extends State<ToDoViewer> {
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
              DbManager().deleteAllData();
              setState(() {});
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: addChild,
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  addChild() {
    DateTime time = DateTime.now();
    final List<ToDoModel> datas =
        new List<int>.generate(10, (index) => index + 1)
            .map((e) => ToDoModel(
                id: null,
                whens: time,
                title: "Test $e",
                contents: "TestContents $e"))
            .toList();
    DbManager().createData(datas[Random().nextInt(datas.length)]);
    print("ADD");
    setState(() {});
  }

  makeList() {
    return FutureBuilder<List<ToDoModel>>(
      future: DbManager().getAllData(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, idx) {
              final item = snapshot.data[idx];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  DbManager().deleteData(item.id);
                  setState(() {});
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
