import 'package:flutter/material.dart';
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/ss_element.dart';
import 'package:ssflow/models/tree_node.dart';

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
  /// canvasに入るものなので、DragTargetのリスト
  List<Widget> canvasObjects = <Widget>[];
  List<SSElement> ssElements = <SSElement>[];

  /// SSElementのnode
  TreeNode get treeNodes => TreeNode.fromList(ssElements);

  double get width => widget.width;

  void clearCanvas() {
    ssElements.clear();
    canvasObjects.clear();
  }

  void buildCanvasObjects(SSElement newElement) {
    L type = newElement.layoutType.toLayoutType!;
    late Widget newWidget;

    Widget sizedContainer(
      double width,
      double height,
      bool willAccepted, {
      double? opacity,
    }) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: willAccepted ? Colors.orange : Colors.black,
            width: willAccepted ? 5.0 : 1.0,
          ),
          color: willAccepted
              ? Colors.white
              : opacity != null
                  ? Colors.green.withOpacity(opacity)
                  : Colors.green,
        ),
        child: Center(
          child: Text(type.value),
        ),
      );
    }

    Widget sizedDraggable(double width, double height) {
      bool _willAccepted = false;
      return GestureDetector(
        onTap: () {
          // for debug
          print('onTap newElement: $newElement');
        },
        child: DragTarget(
          builder: (
            BuildContext context,
            List<Object?> accepted,
            List<dynamic> rejectedData,
          ) {
            return Draggable(
              data: newElement,
              child: sizedContainer(
                width,
                height,
                _willAccepted,
                opacity: 0.7,
              ),
              feedback: Material(
                child: sizedContainer(
                  width,
                  height,
                  _willAccepted,
                  opacity: 0.8,
                ),
              ),
              childWhenDragging: sizedContainer(
                width,
                height,
                _willAccepted,
                opacity: 0.2,
              ),
            );
          },
          onAcceptWithDetails: (DragTargetDetails<SSElement> details) {
            _onAcceptWithDetails(
              details: details,
              thisData: newElement,
            );
          },
          onWillAccept: (SSElement? _map) {
            _willAccepted = true;
            return true;
          },
          onLeave: (SSElement? _map) {
            _willAccepted = false;
          },
        ),
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

    setState(() {
      canvasObjects.add(newWidget);
    });
  }

  void _onAcceptWithDetails({
    DragTargetDetails<SSElement>? details,
    SSElement? thisData,
  }) {
    if (details == null) {
      return;
    }

    setState(() {
      SSElement newElement = details.data;
      newElement.parentUuid = thisData?.uuid;
      ssElements.add(newElement);
      buildCanvasObjects(newElement);
      // errorになる -> if (mounted)でいけるかも？
      // DraggableBlockState.state.setState(() {});
      print(treeNodes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
          DragTarget<SSElement>(
            builder: (
              BuildContext context,
              List<Object?> accepted,
              List<dynamic> rejectedData,
            ) {
              return Center(
                child: Container(
                  width: width * 0.8,
                  height: width * 0.5,
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: canvasObjects),
                  ),
                ),
              );
            },
            onAcceptWithDetails: (DragTargetDetails<SSElement> details) {
              _onAcceptWithDetails(
                details: details,
                thisData: null,
              );
            },
          ),
          /*// parent info for debug
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                Column(
                  children: [
                    Text('Child Object Info'),
                    Text('$childId'),
                    Text(childObject),
                  ],
                ),
                Column(
                  children: [
                    Text('Parent Object Info'),
                    Text('$parentId'),
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
