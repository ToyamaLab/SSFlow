// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/providers/main_area_mode.dart';
import 'package:ssflow/utils/constants/_constants.dart';

class SSFlowLogo extends ConsumerWidget {
  const SSFlowLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(mainAreaMode.notifier).update(MainAreaMode.canvas),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: ref.watch(headerAreaSize).width * 0.01),
          AutoSizeText.rich(
            TextSpan(
              text: 'S',
              style: TextStyle(color: SSColor.primary),
              children: <TextSpan>[
                TextSpan(
                  text: 'SFlow',
                  style: TextStyle(color: SSColor.offWhite),
                ),
              ],
            ),
            presetFontSizes: ref.read(presetFontSizes),
            minFontSize: ref.read(presetFontSizes).reduce(min),
          ),
        ],
      ),
    );
  }
}
