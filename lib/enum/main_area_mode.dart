// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/pages/home_page/main_area/_main_area.dart';
import 'package:ssflow/pages/home_page/main_area/canvas_area.dart';

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
