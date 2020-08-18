import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sql_pratice/bloc/todo_bloc.dart';
import 'package:sql_pratice/constants/constants.dart';
import 'package:sql_pratice/screens/todo_screen.dart';
import 'package:sql_pratice/screens/todo_viewer.dart';
import 'package:sql_pratice/service/SizeConfig.dart';
import 'package:sql_pratice/service/db_manager.dart';

import 'components/list_widget.dart';
import 'components/title_widget.dart';
import 'model/todo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoViewer(),
      debugShowCheckedModeBanner: false,
    );
  }
}
