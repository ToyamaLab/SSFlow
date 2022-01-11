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
    return Container(
      width: ref.watch(headerAreaSize).width,
      height: ref.watch(headerAreaSize).height,
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
