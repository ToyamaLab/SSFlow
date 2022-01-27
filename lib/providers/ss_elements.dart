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
    // add処理を行う前にundo処理をする
    saveUndo();
    state.add(newElement);
    reloadData();
  }

  void update(List<SSElement> ssElements) {
    state = ssElements;
    reloadData();
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
                // delete処理を行う前にundo処理をする
                saveUndo();
                final _node = _read(ssElementsProvider.notifier).treeNode;
                List<String> _uuids = _node.childrenUuids(element.uuid);
                for (String _uuid in _uuids) {
                  _remove(_uuid);
                  _read(canvasObjectsProvider.notifier).remove(_uuid);
                }
                _read(selectedUuid.state).state = '';
                reloadData();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void clear() {
    // clear処理を行う前にundo処理をする
    saveUndo();
    state.clear();
    canvasObjectsController.clear();
    _read(selectedUuid.state).state = '';
    widgetTreeController.clear();
    codeController.clear();
  }

  void reloadData() {
    canvasObjectsController.reload();
    widgetTreeController.generate();
    draggableObjectsController.reload();
    codeController.generate();
  }

  void saveUndo() {
    final previous = [...state];
    _read(undoProvider.notifier).save(previous);
  }

  void _remove(String uuid) =>
      state.removeWhere((element) => element.uuid == uuid);

  TreeNode<SSElement> get treeNode => TreeNode.fromList(state);
}
