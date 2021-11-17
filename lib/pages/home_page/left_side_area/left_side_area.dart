import 'package:flutter/material.dart';
import 'package:ssflow/pages/home_page/left_side_area/draggable_object_area/draggable_object_area.dart';
import 'package:ssflow/pages/home_page/left_side_area/widget_tree_area/widget_tree_area.dart';

/// Widget Treeを表示しておく
class LeftSideArea extends StatefulWidget {
  LeftSideArea(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  _LeftSideAreaState createState() => _LeftSideAreaState();
}

class _LeftSideAreaState extends State<LeftSideArea> {
  List<Widget> _leftSideAreaList = <Widget>[];
  int _selectedIndex = 0;

  double get width => widget.width;

  @override
  Widget build(BuildContext context) {
    _leftSideAreaList = [
      WidgetArea(2 * width / 3.0),
      WidgetTreeArea(2 * width / 3.0),
    ];

    return Material(
      child: Container(
        width: widget.width,
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1 * width / 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.home_filled),
                    color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
                    hoverColor: Colors.deepOrange,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.folder),
                    color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
                    hoverColor: Colors.deepOrange,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            _leftSideAreaList[_selectedIndex],
          ],
        ),
      ),
    );
  }
}
