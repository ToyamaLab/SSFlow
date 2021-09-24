import 'package:flutter/material.dart';

/// widget treeを表示する場所
class WidgetTreeArea extends StatefulWidget {
  WidgetTreeArea(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  _WidgetTreeAreaState createState() => _WidgetTreeAreaState();
}

class _WidgetTreeAreaState extends State<WidgetTreeArea> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: widget.width,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text('Repeat-vertical'),
              children: [
                ExpansionTile(
                  title: Text('row'),
                  children: [
                    ExpansionTile(
                      title: Text('table.id'),
                    ),
                    ExpansionTile(
                      title: Text('table.name'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
