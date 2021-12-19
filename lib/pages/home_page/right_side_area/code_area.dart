// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class CodeArea extends ConsumerWidget {
  const CodeArea({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(rightSideAreaSize).width;
    final _height = ref.watch(rightSideAreaSize).height;
    final _text = ref.watch(codeProvider);

    return Stack(
      children: [
        Positioned(
          left: _width * 0.05,
          top: _height * 0.1,
          width: _width * 0.9,
          height: _height * 0.9,
          child: SelectableText(
            _text,
            style: TextStyle(
              color: SSColor.offWhite,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        _CodeButtons(_text),
      ],
    );
  }
}

class _CodeButtons extends ConsumerWidget {
  final String _query;
  const _CodeButtons(
    this._query, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      right: ref.watch(rightSideAreaSize).width * 0.01,
      top: ref.watch(rightSideAreaSize).height * 0.01,
      child: Row(
        children: [
          IconButton(
            onPressed: () => ref.read(codeProvider.notifier).copy(_query),
            icon: const Icon(Icons.copy),
            color: SSColor.offWhite,
          ),
          IconButton(
            onPressed: () => ref.read(codeProvider.notifier).generate(),
            icon: const Icon(Icons.refresh),
            color: SSColor.offWhite,
          ),
        ],
      ),
    );
  }
}
