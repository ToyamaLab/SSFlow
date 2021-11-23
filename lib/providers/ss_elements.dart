// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';

final ssElementsProvider =
    StateNotifierProvider<_SSElementsControllerNotifier, List<SSElement>>(
  (ref) => _SSElementsControllerNotifier(),
);

class _SSElementsControllerNotifier extends StateNotifier<List<SSElement>> {
  _SSElementsControllerNotifier() : super([]);

  void add(SSElement newElement) {
    state.add(newElement);
  }

  void clear() {
    state.clear();
  }

  TreeNode get treeNodes => TreeNode.fromList(state);
}
