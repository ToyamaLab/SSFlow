// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

final selectedUuid = StateProvider<String>((ref) => '');

AutoDisposeStateNotifierProvider<_SSElementController, SSElement>
    selectedSSElementProvider(Reader read) => ssElementProviders(
          read(selectedUuid),
        );

final ssElementUuid = Provider<String>(
  (ref) => throw UnimplementedError(),
);

final ssElementProviders = StateNotifierProvider.autoDispose
    .family<_SSElementController, SSElement, String>(
  (ref, uuid) => _SSElementController(ref.read, uuid: uuid),
);

class _SSElementController extends StateNotifier<SSElement> {
  final Reader _read;
  final String uuid;
  late RemoveListener _removeListener;
  _SSElementStorage get _storage => _read(ssElementStorage.notifier);

  _SSElementController(
    this._read, {
    required this.uuid,
  }) : super(_read(ssElementStorage.notifier).element(uuid: uuid)) {
    _removeListener = _storage.addListener((_) {
      state = _storage.element(uuid: uuid);
    });
  }

  void updateData(String newData) {
    SSElement _element = _storage.element(uuid: uuid);
    _element.body = newData;
    _storage.update(uuid: uuid, element: _element);
    _read(codeProvider.notifier).generate();
  }

  void updateTableData({
    required String table,
    required String column,
  }) {
    String newData = '$table.$column';
    _storage.element(uuid: uuid).body = newData;
    _read(codeProvider.notifier).generate();
  }

  SSElement assignAfterAndParentUuid({
    required SSElement element,
    required String? parentUuid,
  }) {
    final List<SSElement> _elements = _read(ssElementsProvider);
    late Iterable<SSElement> _children;
    if (parentUuid == null) {
      // Parent element is `root`
      if (_elements.isEmpty) {
        // `element` is the first element
        return element;
      }
      // There's already something
      _children = _elements.where(
        (_element) => _element.parentUuid == null,
      );
    } else {
      element.parentUuid = parentUuid;
      _children = _elements.where(
        (_element) => _element.parentUuid == parentUuid,
      );
    }
    if (_children.isNotEmpty) {
      element.afterUuid = _children.last.uuid;
    }
    return element;
  }

  @override
  void dispose() {
    logger.info('disposed(uuid: $uuid, state: $state)');
    _removeListener();
    super.dispose();
  }
}

final ssElementStorage =
    StateNotifierProvider<_SSElementStorage, Map<String, SSElement>>(
  (ref) => _SSElementStorage(),
);

class _SSElementStorage extends StateNotifier<Map<String, SSElement>> {
  _SSElementStorage() : super({});

  void add({required String uuid, required SSElement element}) =>
      state.addAll({uuid: element});

  void update({required String uuid, required SSElement element}) =>
      state[uuid] = element;

  SSElement element({required String uuid}) => state[uuid]!;
}
