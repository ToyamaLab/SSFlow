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
    return Material(
      child: Container(
        width: ref.watch(leftSideAreaSize).width,
        height: ref.watch(leftSideAreaSize).height,
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
