// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/providers/_providers.dart';

class MainArea extends ConsumerWidget {
  const MainArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(windowSize).width / 4 * 1.5;
    final _height = ref.watch(windowSize).height * 0.9;
    final _size = Size(_width, _height);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(mainAreaSize.notifier).init(context, size: _size),
    );
    return ref.watch(mainAreaMode).widget;
  }
}
