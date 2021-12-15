// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';

enum MainAreaMode {
  canvas,
  code,
  run,
}

extension MainAreaModeExtension on MainAreaMode {
  static final Map<MainAreaMode, Widget> widgets = {
    MainAreaMode.canvas: const CanvasArea(),
    MainAreaMode.code: const CodeArea(),
    MainAreaMode.run: const RunArea(),
  };

  Widget get widget => widgets[this]!;
}
