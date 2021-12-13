// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

/// widget treeを表示する場所
class WidgetTreeArea extends ConsumerWidget {
  const WidgetTreeArea({
    Key? key,
  }) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: ref.watch(widgetTreeProvider),
        ),
      ),
    );
  }
}
