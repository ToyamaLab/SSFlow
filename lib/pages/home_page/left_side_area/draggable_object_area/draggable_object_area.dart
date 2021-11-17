import 'package:flutter/material.dart';
import 'package:ssflow/models/draggable_objects/_draggable_objects.dart';

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
            SSDraggableColumn(),
            SSDraggableRow(),
            SSDraggableRepeatVertical(),
            SSDraggableRepeatHorizontal(),
            SSDraggableText(),
            SSDraggableFunction(),
            SSDraggableTableData(),
            SSDraggableBlock(),
          ],
        ),
      ),
    );
  }
}
