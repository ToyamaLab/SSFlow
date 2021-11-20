// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/pages/home_page/app_bar/ssflow_logo.dart';
import 'package:ssflow/providers/_providers.dart';
import 'attribute_area/attribute_area.dart';
import 'canvas_area/canvas_area.dart';
import 'left_side_area/left_side_area.dart';

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
        const SSFlowLogo(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            LeftSideArea(),
            CanvasArea(),
            AttributeArea(),
          ],
        ),
      ],
    );
  }
}
