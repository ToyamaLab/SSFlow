// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/ss_element.dart';
import 'package:ssflow/models/tree_node.dart';

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
