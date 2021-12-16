// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

/// Widget Treeを表示しておく
class LeftSideArea extends ConsumerWidget {
  const LeftSideArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(windowSize).width / 4 * 1.5;
    final _height = ref.watch(windowSize).height * 0.9;
    final _mode = ref.watch(leftSideAreaMode);
    final _size = Size(_width, _height);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(leftSideAreaSize.notifier).init(context, size: _size),
    );

    return Material(
      child: Container(
        width: _width,
        height: _height,
        color: SSColor.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1 * _width / 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home_filled),
                    color: _mode == LeftSideAreaMode.draggableObjectArea
                        ? SSColor.primary
                        : Colors.grey,
                    hoverColor: Colors.deepOrange,
                    onPressed: () => ref
                        .read(leftSideAreaMode.notifier)
                        .update(LeftSideAreaMode.draggableObjectArea),
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder),
                    color: _mode == LeftSideAreaMode.widgetTree
                        ? SSColor.primary
                        : Colors.grey,
                    hoverColor: Colors.deepOrange,
                    onPressed: () => ref
                        .read(leftSideAreaMode.notifier)
                        .update(LeftSideAreaMode.widgetTree),
                  ),
                ],
              ),
            ),
            _mode.widget,
          ],
        ),
      ),
    );
  }
}
