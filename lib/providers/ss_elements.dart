// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';

final ssElementsProvider =
    StateNotifierProvider<_SSElementsController, List<SSElement>>(
  (ref) => _SSElementsController(ref.read),
);

class _SSElementsController extends StateNotifier<List<SSElement>> {
  final Reader _read;
  late CanvasObjectsController canvasObjectsController;
  late WidgetTreeController widgetTreeController;
  late DraggableObjectsController draggableObjectsController;
  late CodeController codeController;
  _SSElementsController(this._read) : super([]) {
    canvasObjectsController = _read(canvasObjectsProvider.notifier);
    widgetTreeController = _read(widgetTreeProvider.notifier);
    draggableObjectsController = _read(draggableObjectsProvider.notifier);
    codeController = _read(codeProvider.notifier);
  }
  void add(SSElement newElement) {
    state.add(newElement);
    canvasObjectsController.add(newElement);
    widgetTreeController.generate();
    draggableObjectsController.reload();
    codeController.generate();
  }

  void delete(SSElement element) async {
    final context = _read(navigatorKeyProvider).currentContext!;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('このブロックを削除しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final _node = _read(ssElementsProvider.notifier).treeNode;
                List<String> _uuids = _node.childrenUuids(element.uuid);
                for (String _uuid in _uuids) {
                  _remove(_uuid);
                  _read(canvasObjectsProvider.notifier).remove(_uuid);
                }
                _read(selectedUuid.state).state = '';
                widgetTreeController.generate();
                codeController.generate();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _remove(String uuid) =>
      state.removeWhere((element) => element.uuid == uuid);

  void clear() {
    state.clear();
    canvasObjectsController.clear();
    _read(selectedUuid.state).state = '';
    widgetTreeController.clear();
    codeController.clear();
  }

  TreeNode<SSElement> get treeNode => TreeNode.fromList(state);
}
