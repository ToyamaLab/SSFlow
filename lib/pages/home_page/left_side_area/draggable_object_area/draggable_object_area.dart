import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ssflow/models/draggable_objects/_draggable_objects.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

class WidgetArea extends ConsumerWidget {
  const WidgetArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = 2 * ref.watch(leftSideAreaSize).width / 3.0;

    return Material(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: SSColor.grey,
              width: 1.0,
            ),
          ),
          color: SSColor.black,
        ),
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
