// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';

final ssElementsProvider =
    StateNotifierProvider<_SSElementsControllerNotifier, List<SSElement>>(
  (ref) => _SSElementsControllerNotifier(ref.read),
);

class _SSElementsControllerNotifier extends StateNotifier<List<SSElement>> {
  final Reader _read;
  late CanvasObjectsController canvasObjectsController;

  _SSElementsControllerNotifier(this._read) : super([]) {
    canvasObjectsController = _read(canvasObjectsProvider.notifier);
  }

  void add(SSElement newElement) {
    state.add(newElement);
    canvasObjectsController.add(newElement);
  }

  void clear() {
    state.clear();
    canvasObjectsController.clear();
  }

  TreeNode get treeNodes => TreeNode.fromList(state);
}
