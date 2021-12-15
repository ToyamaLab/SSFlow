// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';

final mainAreaMode = StateNotifierProvider<_MainAreaController, MainAreaMode>(
  (ref) => _MainAreaController(),
);

class _MainAreaController extends StateNotifier<MainAreaMode> {
  _MainAreaController() : super(MainAreaMode.canvas);

  void update(MainAreaMode newMode) => state = newMode;
}
