// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';

class DraggableObjectArea extends ConsumerWidget {
  const DraggableObjectArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: ref.watch(draggableObjectsProvider),
    );
  }
}
