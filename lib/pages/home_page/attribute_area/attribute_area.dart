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
    return Center(
      child: Container(
        width: ref.watch(attributeAreaSize).width,
        height: ref.watch(attributeAreaSize).height,
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
