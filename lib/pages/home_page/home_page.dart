import 'package:flutter/material.dart';

import 'attribute_area/attribute_area.dart';
import 'canvas_area/canvas_area.dart';
import 'widget_area/widget_area.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final quarterWidth = width / 4;
    return Row(
      children: [
        WidgetArea(1 * quarterWidth),
        CanvasArea(2 * quarterWidth),
        AttributeArea(1 * quarterWidth),
      ],
    );
  }
}
