// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class RightSideArea extends ConsumerWidget {
  const RightSideArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: ref.watch(rightSideAreaSize).width,
      height: ref.watch(rightSideAreaSize).height,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: SSColor.grey,
            width: 1.0,
          ),
        ),
        color: SSColor.black,
      ),
      child: ref.watch(rightSideAreaMode).widget,
    );
  }
}
