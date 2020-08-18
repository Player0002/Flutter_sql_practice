import 'package:flutter/material.dart';
import 'package:sql_pratice/model/todo_model.dart';

class TodoScreen extends StatelessWidget {
  final ToDoModel model;
  TodoScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  model.title,
                ),
              ),
            ),
            Text(model.contents),
          ],
        ),
      ),
    );
  }
}
