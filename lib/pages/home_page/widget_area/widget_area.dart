import 'package:flutter/material.dart';

import '_widget_area.dart';

class WidgetArea extends StatelessWidget {
  WidgetArea(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: width,
        color: Colors.red,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: [
            ColumnWidget(),
            RowWidget(),
            RepeatVerticalWidget(),
            RepeatHorizontalWidget(),
            TextWidget(),
            FunctionWidget(),
            TableDataWidget(),
            BlockWidget(),
          ],
        ),
      ),
    );
  }
}
