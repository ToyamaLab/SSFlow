// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class RunButton extends ConsumerWidget {
  const RunButton({
    Key? key,
  }) : super(key: key);
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
            onPressed: () async {
              // 最終的にはローカルのHTMLファイルをロードしてくる #67
              await ref
                  .read(mainAreaMode.notifier)
                  .launchUrl('https://google.com');
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
