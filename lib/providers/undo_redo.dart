// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';

final undoProvider =
    StateNotifierProvider<_UndoController, List<List<SSElement>>>(
  (ref) => _UndoController(ref.read),
);

final redoProvider =
    StateNotifierProvider<_RedoController, List<List<SSElement>>>(
  (ref) => _RedoController(ref.read),
);

abstract class _UndoRedoController
    extends StateNotifier<List<List<SSElement>>> {
  Reader read;
  _UndoRedoController(this.read) : super([]);

  // []と[[]]ではisNotEmptyの判定が異なるので、どちらにも対応するようにする
  // ref:
  /// final row = [];
  /// print(row.every((e) => e.isNotEmpty)); // true
  /// print(row.isNotEmpty);                 // false
  ///
  /// final row2 = [[]];
  /// print(row2.every((e) => e.isNotEmpty)); // false
  /// print(row2.isNotEmpty);                 // true
  ///
  bool get isEnabled =>
      state.isNotEmpty ||
      (state.isNotEmpty && state.every((e) => e.isNotEmpty));
  void push(List<SSElement> value) => state.add(value);
  void clear() => state = [];
  List<SSElement>? pop() {
    if (isEnabled) {
      return state.removeLast();
    } else {
      return null;
    }
  }

  void execute() {
    if (isEnabled) {
      final List<SSElement> _last = pop()!;
      final List<SSElement> current = read(ssElementsProvider.notifier).state;
      final _opposite = this is _UndoController ? redoProvider : undoProvider;
      read(_opposite.notifier).push(current);
      read(ssElementsProvider.notifier).update(_last);
      read(selectedUuid.state).state = '';
    }
  }
}

class _UndoController extends _UndoRedoController {
  _UndoController(read) : super(read);
  void save(List<SSElement>? value) {
    if (value != null) {
      push(value);
      read(redoProvider.notifier).clear();
    }
  }
}

class _RedoController extends _UndoRedoController {
  _RedoController(read) : super(read);
}
