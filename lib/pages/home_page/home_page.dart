// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';
import 'package:ssflow/providers/_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(windowSize.notifier).init(context),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Header(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            LeftSideArea(),
            MainArea(),
            AttributeArea(),
          ],
        ),
      ],
    );
  }
}
