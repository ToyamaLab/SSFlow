import 'package:flutter/material.dart';
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/converter.dart';
import 'package:ssflow/models/tfe_map.dart';

class CanvasArea extends StatefulWidget {
  CanvasArea(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  CanvasAreaState createState() => CanvasAreaState();
}

class CanvasAreaState extends State<CanvasArea> {
  String acceptedData = 'none';
  String parentId = '---';
  String parentObject = '---';
  String childId = '---';
  String childObject = '---';
  static List<Widget> canvasWidgets = <Widget>[];
  static List<TFEMap> widgetTree = <TFEMap>[];
  static Converter converter = Converter();

  Converter get _converter => converter;

  void clearCanvas() {
    widgetTree.clear();
    canvasWidgets.clear();
    converter.maxID = 0;
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
      TFEMap? map;
      return DragTarget(
        builder: (
          BuildContext context,
          List<Object?> accepted,
          List<dynamic> rejectedData,
        ) {
          return Draggable<TFEMap>(
            data: map ??
                {
                  'id': -1,
                  // TODO: layout-type動的にする
                  'layout-type': 'block',
                  'parent': null,
                  'after': null,
                  'body': null,
                },
            child: sizedContainer(width, height, opacity: 0.7),
            feedback: Material(
              child: sizedContainer(width, height, opacity: 0.8),
            ),
            childWhenDragging: sizedContainer(width, height, opacity: 0.2),
          );
        },
        onAcceptWithDetails: (DragTargetDetails details) {
          setState(() {
            final map = details.data;
            _converter.appendTFE(
              layoutType: map['layout-type'],
              // TODO: 親要素を取得してその値にする
              parent: 1,
            );
            addToCanvas(map['layout-type']);
          });
        },
        onMove: (DragTargetDetails details) {
          map = details.data;
          if (childObject != map!['layout-type']) {
            setState(() {
              childObject = map!['layout-type'];
              childId = map!['id'];
            });
          }
        },
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
            onAcceptWithDetails: (DragTargetDetails details) {
              setState(() {
                final map = details.data;
                _converter.appendTFE(
                  layoutType: map['layout-type'],
                );
                addToCanvas(map['layout-type']);
              });
            },
            onMove: (DragTargetDetails details) {
              final map = details.data;
              if (childObject != map['layout-type']) {
                setState(() {
                  childObject = map['layout-type'];
                  childId = map['id'].toString();
                });
              }
            },
          ),
          /* parent info for debug
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                Column(
                  children: [
                    Text('Child Object Info'),
                    Text(childId),
                    Text(childObject),
                  ],
                ),
                Column(
                  children: [
                    Text('Parent Object Info'),
                    Text(parentId),
                    Text(parentObject),
                  ],
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
