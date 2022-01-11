// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';

enum RightSideAreaMode {
  attribute,
  code,
}

extension RightSideAreaModeExtension on RightSideAreaMode {
  static final Map<RightSideAreaMode, Widget> widgets = {
    RightSideAreaMode.attribute: const AttributeArea(),
    RightSideAreaMode.code: const CodeArea(),
  };

  Widget get widget => widgets[this]!;
}
