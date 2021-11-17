import 'package:flutter/material.dart';
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/ss_element.dart';

class DraggableObject extends StatelessWidget {
  final L l;
  final double width;
  final double height;

  DraggableObject(
    this.l, {
    this.width = 100.0,
    this.height = 100.0 / 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<SSElement>(
      data: SSElement(l.value),
      child: Container(
        width: width,
        height: height,
        color: Colors.blue,
        child: Center(
          child: Text(l.value),
        ),
      ),
      feedback: Material(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 3.0,
            ),
            color: Colors.blue.withOpacity(0.3),
          ),
          child: Center(
            child: Text(l.value),
          ),
        ),
      ),
    );
  }
}
