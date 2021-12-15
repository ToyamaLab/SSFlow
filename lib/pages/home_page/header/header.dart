// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class Header extends ConsumerWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(windowSize).width;
    final _height = ref.watch(windowSize).height * 0.1;
    final _size = Size(_width, _height);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(headerAreaSize.notifier).init(context, size: _size),
    );

    return Container(
      height: _height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: SSColor.grey,
            width: 1.0,
          ),
        ),
        color: SSColor.black,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SSFlowLogo(),
          HeaderButtons(),
        ],
      ),
    );
  }
}
