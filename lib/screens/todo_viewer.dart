import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sql_pratice/bloc/todo_bloc.dart';
import 'package:sql_pratice/components/list_widget.dart';
import 'package:sql_pratice/components/title_widget.dart';
import 'package:sql_pratice/model/todo_model.dart';
import 'package:sql_pratice/screens/todo_screen.dart';
import 'package:sql_pratice/service/SizeConfig.dart';

final List<ToDoModel> datas = new List<int>.generate(10, (index) => index + 1)
    .map((e) => ToDoModel(
        id: null,
        whens: DateTime.now(),
        title: "Test $e ${strs[e - 1]}",
        contents: "TestContents $e"))
    .toList();
final List<String> strs = [
  "COiZCfyCLx",
  "zrcSmXqIxk",
  "MlnNgRpUnT",
  "dhjQpDNCXl",
  "DuJoXZDCFf",
  "YNcxWIltLi",
  "prUcFrdNQL",
  "FduqiLrTIp",
  "jECVtClgQL",
  "IWQGrRaDDj",
];

class ToDoViewer extends StatelessWidget {
  final ToDoBloc bloc = ToDoBloc();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Reminder",
          style: TextStyle(color: Colors.blueAccent),
        ),
        centerTitle: true,
      ),
      body: makeList(),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "h1",
            onPressed: () {
              bloc.deleteAll();
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "h2",
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
              final random = Random();
              final item = snapshot.data[idx];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  bloc.deleteTodo(item.id);
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                          builder: (ctx) => TodoScreen(model: item)),
                    );
                  },
                  child: Container(
                    color: Color.fromARGB(
                      255,
                      random.nextInt(255),
                      random.nextInt(255),
                      random.nextInt(255),
                    ),
                    child: Row(
                      children: [
                        ListWidget(
                          day: item.whens.day + 1,
                        ),
                        TitleWidget(item: item),
                      ],
                    ),
                  ),
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
