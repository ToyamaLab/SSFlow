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
    final _leftWidth = ref.watch(leftSideAreaSize).width;
    final _iconWidth = ref.watch(iconButtonsAreaSize).width;
    return Material(
      child: Container(
        width: _leftWidth,
        height: ref.watch(leftSideAreaSize).height,
        color: SSColor.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconButtonsArea(),
            Material(
              child: Container(
                width: _leftWidth - _iconWidth,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: SSColor.grey,
                      width: 1.0,
                    ),
                  ),
                  color: SSColor.black,
                ),
                child: ref.watch(leftSideAreaMode).widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
