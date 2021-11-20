import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final windowSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final leftSideAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final canvasAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController(),
);
final attributeAreaSize = StateNotifierProvider<_SizeController, Size>(
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
