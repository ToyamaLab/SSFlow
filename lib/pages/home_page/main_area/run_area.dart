// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/size.dart';

class RunArea extends ConsumerWidget {
  const RunArea({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: ref.watch(mainAreaSize).width,
      child: const Center(
        child: Text('Run Area'),
      ),
    );
  }
}
