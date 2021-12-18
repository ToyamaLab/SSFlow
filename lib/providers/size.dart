// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _Watcher = T Function<T>(AlwaysAliveProviderListenable<T>);

final rightSideAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController.rightSideArea(ref.watch),
  dependencies: [windowSize],
);
final headerAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController.headerArea(ref.watch),
  dependencies: [windowSize],
);
final iconButtonsAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController.iconButtonsArea(ref.watch),
  dependencies: [windowSize],
);
final leftSideAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController.leftSideArea(ref.watch),
  dependencies: [windowSize],
);
final mainAreaSize = StateNotifierProvider<_SizeController, Size>(
  (ref) => _SizeController.mainArea(ref.watch),
  dependencies: [windowSize],
);
final windowSize = StateProvider<Size>(
  (ref) => Size.zero,
);

class _SizeController extends StateNotifier<Size> {
  _SizeController.rightSideArea(_Watcher _watch) : super(Size.zero) {
    final _width = _watch(windowSize).width * 2.5 / 10;
    final _height = _watch(windowSize).height * 0.9;
    state = Size(_width, _height);
  }
  _SizeController.headerArea(_Watcher _watch) : super(Size.zero) {
    final _width = _watch(windowSize).width;
    final _height = _watch(windowSize).height * 0.1;
    state = Size(_width, _height);
  }
  _SizeController.iconButtonsArea(_Watcher _watch) : super(Size.zero) {
    final _width = _watch(windowSize).width * 0.5 / 10;
    final _height = _watch(windowSize).height * 0.9;
    state = Size(_width, _height);
  }
  _SizeController.leftSideArea(_Watcher _watch) : super(Size.zero) {
    final _width = _watch(windowSize).width * 2.5 / 10;
    final _height = _watch(windowSize).height * 0.9;
    state = Size(_width, _height);
  }
  _SizeController.mainArea(_Watcher _watch) : super(Size.zero) {
    final _width = _watch(windowSize).width * 5 / 10;
    final _height = _watch(windowSize).height * 0.9;
    state = Size(_width, _height);
  }
}
