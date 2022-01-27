// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';

abstract class _UndoRedoBase extends StateNotifier<List<List<SSElement>>> {
  _UndoRedoBase() : super([]);

  // []と[[]]ではisNotEmptyの判定が異なるので、どちらにも対応するようにする
  // ref:
  /// final row = [];
  /// print(row.every((e) => e.isNotEmpty)); // true
  /// print(row.isNotEmpty);                 // false
  ///
  /// final row2 = [[]];
  /// print(row.every((e) => e.isNotEmpty)); // false
  /// print(row.isNotEmpty);                 // true
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
}

final undoProvider =
    StateNotifierProvider<_UndoController, List<List<SSElement>>>(
  (ref) => _UndoController(ref.read),
);

class _UndoController extends _UndoRedoBase {
  final Reader _read;
  _UndoController(this._read) : super();

  void undo() {
    if (isEnabled) {
      final List<SSElement> _last = pop()!;
      final List<SSElement> current = _read(ssElementsProvider.notifier).state;
      _read(redoProvider.notifier).push(current);
      _read(ssElementsProvider.notifier).update(_last);
    }
  }

  void save(List<SSElement>? value) {
    if (value != null) {
      push(value);
      _read(redoProvider.notifier).clear();
    }
  }
}

final redoProvider =
    StateNotifierProvider<_RedoController, List<List<SSElement>>>(
  (ref) => _RedoController(ref.read),
);

class _RedoController extends _UndoRedoBase {
  final Reader _read;
  _RedoController(this._read) : super();

  void redo() {
    if (isEnabled) {
      final List<SSElement> _last = pop()!;
      final List<SSElement> current = _read(ssElementsProvider.notifier).state;
      _read(undoProvider.notifier).push(current);
      _read(ssElementsProvider.notifier).update(_last);
    }
  }
}
