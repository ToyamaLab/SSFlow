import 'package:flutter/material.dart';
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/converter.dart';
import 'package:ssflow/models/tfe_map.dart';

abstract class DraggableWidget extends StatelessWidget {
  DraggableWidget(
    this.l, {
    this.width = 100.0,
    this.height = 100.0 / 2,
    Key? key,
  }) : super(key: key);

  final L l;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    TFEMap map = Converter().createTFE(
      layoutType: l.value,
      id: 0,
    );
    return Draggable<TFEMap>(
      data: map,
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
