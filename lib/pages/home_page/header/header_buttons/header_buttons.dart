// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';
import 'package:ssflow/providers/_providers.dart';

class HeaderButtons extends ConsumerWidget {
  const HeaderButtons({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(headerAreaSize).width;
    return Row(
      children: [
        const RunButton(),
        SizedBox(width: _width * 0.018),
        const CodeButton(),
        SizedBox(width: _width * 0.08),
      ],
    );
  }
}
