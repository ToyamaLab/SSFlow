// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';

final rightSideAreaMode =
    StateNotifierProvider<_RightSideAreaController, RightSideAreaMode>(
  (ref) => _RightSideAreaController(),
);

class _RightSideAreaController extends StateNotifier<RightSideAreaMode> {
  _RightSideAreaController() : super(RightSideAreaMode.attribute);

  void update(RightSideAreaMode newMode) => state = newMode;
}
