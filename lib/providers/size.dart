// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attributeAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final headerAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final iconButtonsAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final leftSideAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final mainAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final windowSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);

class _SizeController extends StateNotifier<Size> {
  _SizeController() : super(Size.zero);

  Future<void> init(
    BuildContext context, {
    Size? size,
  }) async {
    if (size != null) {
      state = size;
      return;
    }

    state = MediaQuery.of(context).size;
  }
}
