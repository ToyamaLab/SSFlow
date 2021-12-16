// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';

final leftSideAreaMode =
    StateNotifierProvider<_LeftSideAreaController, LeftSideAreaMode>(
  (ref) => _LeftSideAreaController(),
);

class _LeftSideAreaController extends StateNotifier<LeftSideAreaMode> {
  _LeftSideAreaController() : super(LeftSideAreaMode.draggableObjectArea);

  void update(LeftSideAreaMode newMode) => state = newMode;
}
