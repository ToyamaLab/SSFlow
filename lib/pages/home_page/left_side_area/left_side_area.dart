// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/pages/_pages.dart';
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
            const IconButtonsArea(),
            ref.watch(leftSideAreaMode).widget,
          ],
        ),
      ),
    );
  }
}
