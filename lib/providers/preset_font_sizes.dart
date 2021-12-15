// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final presetFontSizes =
    StateNotifierProvider<_AutoSizeController, List<double>>(
  (ref) => _AutoSizeController(),
);

class _AutoSizeController extends StateNotifier<List<double>> {
  _AutoSizeController() : super([32, 24, 16, 8]);
}
