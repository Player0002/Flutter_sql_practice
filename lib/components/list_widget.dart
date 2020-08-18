import 'package:flutter/cupertino.dart';
import 'package:sql_pratice/constants/constants.dart';
import 'package:sql_pratice/service/SizeConfig.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key key,
    @required this.day,
  }) : super(key: key);

  final int day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 20,
      height: SizeConfig.blockSizeHorizontal * 20,
      child: Center(
        child: Text(
          day.toString(),
          style: kDayFont.copyWith(
            fontSize: SizeConfig.blockSizeHorizontal * 8,
          ),
        ),
      ),
    );
  }
}
