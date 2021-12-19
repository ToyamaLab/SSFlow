// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textDataController = StateNotifierProvider.autoDispose<_EditingController,
    TextEditingController>(
  (ref) => _EditingController(),
);
final dbTableController = StateNotifierProvider.autoDispose<_EditingController,
    TextEditingController>(
  (ref) => _EditingController(),
);
final dbColumnController = StateNotifierProvider.autoDispose<_EditingController,
    TextEditingController>(
  (ref) => _EditingController(),
);

class _EditingController extends StateNotifier<TextEditingController> {
  _EditingController()
      : super(
          TextEditingController(text: 'selected element data'),
        );

  void update(String newText) => state = TextEditingController(text: newText);
}
