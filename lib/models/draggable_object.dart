// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class DraggableObject extends ConsumerWidget {
  final L l;
  final double width;
  final double height;
  final String body;

  const DraggableObject(
    this.l, {
    this.body = '',
    this.width = 100.0,
    this.height = 100.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _newElement = SSElement(l.value, body: body);
    final _uuid = _newElement.uuid;
    ref.read(ssElementStorage.notifier).add(uuid: _uuid, element: _newElement);

    return ProviderScope(
      key: ValueKey(_uuid),
      overrides: [
        ssElementUuid.overrideWithValue(_uuid),
      ],
      child: Draggable<SSElement>(
        data: _newElement,
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
                  style: TextStyle(color: SSColor.black),
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
        onDragStarted: () => ref.read(selectedUuid.state).state = '',
      ),
    );
  }
}
