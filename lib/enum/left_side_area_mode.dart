// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';

enum LeftSideAreaMode {
  draggableObjectArea,
  widgetTree,
  code,
}

extension LeftSideAreaModeExtension on LeftSideAreaMode {
  static final Map<LeftSideAreaMode, Widget> widgets = {
    LeftSideAreaMode.draggableObjectArea: const DraggableObjectArea(),
    LeftSideAreaMode.widgetTree: const WidgetTreeArea(),
    LeftSideAreaMode.code: const SizedBox(),
  };

  Widget get widget => widgets[this]!;
}
