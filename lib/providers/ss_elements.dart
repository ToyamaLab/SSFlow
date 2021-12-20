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

  void clear() {
    state.clear();
    canvasObjectsController.clear();
    widgetTreeController.clear();
    codeController.clear();
  }

  TreeNode<SSElement> get treeNode => TreeNode.fromList(state);
}
