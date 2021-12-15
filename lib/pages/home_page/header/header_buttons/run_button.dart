// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/providers/main_area_mode.dart';
import 'package:ssflow/utils/constants/ss_color.dart';

class RunButton extends ConsumerWidget {
  const RunButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _mode = ref.watch(mainAreaMode);
    final _size = ref.watch(headerAreaSize);
    final _minimumSize = Size(_size.width * 0.1, _size.height * 0.5);
    return Row(
      children: [
        ButtonTheme(
          height: ref.watch(headerAreaSize).height * 0.5,
          child: OutlinedButton(
            onPressed: () {
              if (_mode == MainAreaMode.run) {
                ref.read(mainAreaMode.notifier).update(MainAreaMode.canvas);
              } else {
                ref.read(mainAreaMode.notifier).update(MainAreaMode.run);
              }
            },
            child: AutoSizeText(
              _mode == MainAreaMode.run ? 'Canvas' : 'Run',
              presetFontSizes: ref.read(presetFontSizes),
              style: TextStyle(
                color: SSColor.offWhite,
                fontWeight: FontWeight.normal,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: SSColor.offWhite),
              minimumSize: _minimumSize,
            ),
          ),
        ),
      ],
    );
  }
}
