// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class AttributeArea extends ConsumerWidget {
  const AttributeArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(windowSize).width / 4;
    final _height = ref.watch(windowSize).height * 0.9;
    final _size = Size(_width, _height);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(attributeAreaSize.notifier).init(context, size: _size),
    );

    return Center(
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: SSColor.grey,
              width: 1.0,
            ),
          ),
          color: SSColor.black,
        ),
      ),
    );
  }
}
