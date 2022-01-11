// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';

/// widget treeを表示する場所
class WidgetTreeArea extends ConsumerWidget {
  const WidgetTreeArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: ref.watch(widgetTreeProvider),
    );
  }
}
