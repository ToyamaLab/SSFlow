import 'package:flutter/material.dart';
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/tfe_map.dart';

class CanvasArea extends StatefulWidget {
  CanvasArea(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  _CanvasAreaState createState() => _CanvasAreaState();
}

class _CanvasAreaState extends State<CanvasArea> {
  String acceptedData = 'none';
  TFEMap map = TFEMap();
  List<Widget> canvasWidgets = <Widget>[];

  void createTFEMap(String l) {
    TFEMap newMap = {l: null};
    map.addAll(newMap);
  }

  void clearCanvas() {
    map.clear();
    canvasWidgets.clear();
  }

  void addToCanvas(String l) {
    L type = l.toLayoutType!;
    Widget? newWidget;

    Widget sizedContainer(
      double width,
      double height, {
      double? opacity,
    }) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: opacity != null
              ? Colors.green.withOpacity(opacity)
              : Colors.green,
        ),
        child: Center(
          child: Text(type.value),
        ),
      );
    }

    Widget sizedDraggable(double width, double height) {
      return Draggable(
        data: type.value,
        child: sizedContainer(width, height, opacity: 0.7),
        feedback: Material(
          child: sizedContainer(width, height, opacity: 0.8),
        ),
        childWhenDragging: sizedContainer(width, height, opacity: 0.2),
      );
    }

    switch (type) {
      case L.column:
        newWidget = sizedDraggable(50, 100);
        break;
      case L.row:
        newWidget = sizedDraggable(100, 50);
        break;
      case L.repeatVertical:
        newWidget = sizedDraggable(50, 100);
        break;
      case L.repeatHorizontal:
        newWidget = sizedDraggable(100, 50);
        break;
      case L.text:
        newWidget = sizedDraggable(100, 100);
        break;
      case L.function:
        newWidget = sizedDraggable(100, 100);
        break;
      case L.tableData:
        newWidget = sizedDraggable(100, 100);
        break;
      case L.block:
        newWidget = sizedDraggable(100, 100);
        break;
    }

    canvasWidgets.add(newWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 10.0,
            right: 10.0,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  clearCanvas();
                });
              },
            ),
          ),
          DragTarget(
            builder: (
              BuildContext context,
              List<Object?> accepted,
              List<dynamic> rejectedData,
            ) {
              return Center(
                child: Container(
                  width: this.widget.width * 0.8,
                  height: this.widget.width * 0.5,
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: canvasWidgets,
                    ),
                  ),
                ),
              );
            },
            onAccept: (String layoutValue) {
              setState(() {
                acceptedData = layoutValue;
                createTFEMap(layoutValue);
                addToCanvas(layoutValue);
              });
            },
          ),
        ],
      ),
    );
  }
}
