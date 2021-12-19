// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/utils/_utils.dart';

class DraggableObject extends StatelessWidget {
  final L l;
  final double width;
  final double height;

  const DraggableObject(
    this.l, {
    this.width = 100.0,
    this.height = 100.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<SSElement>(
      data: SSElement(l.value),
      child: Container(
        width: width,
        height: height,
        color: SSColor.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                l.value,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: SSColor.black,
                ),
              ),
              Icon(l.iconData),
            ],
          ),
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
            color: SSColor.offWhite.withOpacity(0.3),
          ),
          child: Center(
            child: Text(
              l.value,
              style: TextStyle(color: SSColor.black),
            ),
          ),
        ),
      ),
    );
  }
}
