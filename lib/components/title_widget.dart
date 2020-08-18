import 'package:flutter/material.dart';
import 'package:sql_pratice/constants/constants.dart';
import 'package:sql_pratice/model/todo_model.dart';
import 'package:sql_pratice/service/SizeConfig.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  final ToDoModel item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style:
                kDayFont.copyWith(fontSize: SizeConfig.blockSizeHorizontal * 4),
          ),
          Text(
            "${DateTime.now().difference(item.whens).inDays} days ago..",
            style: kDayFont.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
