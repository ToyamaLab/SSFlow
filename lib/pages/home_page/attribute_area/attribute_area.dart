import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

class AttributeArea extends ConsumerWidget {
  const AttributeArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = ref.watch(windowSize).width / 4;
    final height = ref.watch(windowSize).height * 0.9;
    final _size = Size(width, height);
    Future.delayed(Duration.zero, () {
      ref.read(attributeAreaSize.notifier).init(context, size: _size);
    });

    return Center(
      child: Container(
        width: width,
        height: height,
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
