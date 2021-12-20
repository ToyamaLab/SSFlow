// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

final canvasObjectsProvider =
    StateNotifierProvider<CanvasObjectsController, List<Widget>>(
  (ref) => CanvasObjectsController(ref.read),
);

class CanvasObjectsController extends StateNotifier<List<Widget>> {
  final Reader _read;

  CanvasObjectsController(this._read) : super(<Widget>[]);

  void clear() => state = <Widget>[];

  void add(SSElement newElement) {
    L type = newElement.layoutType.toLayoutType!;
    late Widget newWidget;

    switch (type) {
      case L.column:
        newWidget = _SizedDraggable(newElement, 50, 100);
        break;
      case L.row:
        newWidget = _SizedDraggable(newElement, 100, 50);
        break;
      case L.repeatVertical:
        newWidget = _SizedDraggable(newElement, 50, 100);
        break;
      case L.repeatHorizontal:
        newWidget = _SizedDraggable(newElement, 100, 50);
        break;
      case L.text:
        newWidget = _SizedDraggable(newElement, 100, 100);
        break;
      case L.function:
        newWidget = _SizedDraggable(newElement, 100, 100);
        break;
      case L.tableData:
        newWidget = _SizedDraggable(newElement, 100, 100);
        break;
      case L.block:
        newWidget = _SizedDraggable(newElement, 100, 100);
        break;
    }

    state = [...state, newWidget];
  }

  void onAcceptWithDetails({
    DragTargetDetails<SSElement>? newData,
    SSElement? parentElement,
  }) {
    if (newData == null) {
      return;
    }

    if (!_canAddObject(parentElement)) {
      return;
    }

    SSElement newElement = newData.data;
    newElement.parentUuid = parentElement?.uuid;
    _read(ssElementsProvider.notifier).add(newElement);
    final treeNodes = _read(ssElementsProvider.notifier).treeNode;
    logger.info(treeNodes);
  }

  void remove(String uuid) {
    state.removeWhere(
      (widget) => (widget as _SizedDraggable)._newElement.uuid == uuid,
    );
    state = [...state];
  }

  bool _canAddObject(SSElement? parentElement) {
    if (parentElement == null) {
      return true;
    }

    if (parentElement.layoutType.toLayoutType!.isLayoutElement()) {
      return true;
    } else {
      EasyLoading.showError(
        'このブロックは追加できません。\n親要素にはレイアウトブロックを追加してください。',
      );
      return false;
    }
  }
}

class _SizedDraggable extends ConsumerWidget {
  final SSElement _newElement;
  final double _width, _height;
  late final StateProvider<bool> _willAcceptedProvider;

  _SizedDraggable(
    this._newElement,
    this._width,
    this._height, {
    Key? key,
  }) : super(key: key) {
    _willAcceptedProvider = StateProvider<bool>((_) => false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(selectedUuid.state).state = _newElement.uuid,
      onSecondaryTap: () =>
          ref.read(ssElementsProvider.notifier).delete(_newElement),
      child: DragTarget(
        builder: (
          BuildContext context,
          List<Object?> accepted,
          List<dynamic> rejectedData,
        ) {
          return Draggable(
            data: _newElement,
            child: _SizedContainer(
              _newElement,
              _willAcceptedProvider,
              _width,
              _height,
              opacity: 0.7,
            ),
            feedback: Material(
              child: _SizedContainer(
                _newElement,
                _willAcceptedProvider,
                _width,
                _height,
                opacity: 0.8,
              ),
            ),
            childWhenDragging: _SizedContainer(
              _newElement,
              _willAcceptedProvider,
              _width,
              _height,
              opacity: 0.2,
            ),
            onDragStarted: () => ref.read(selectedUuid.state).state = '',
          );
        },
        onAcceptWithDetails: (DragTargetDetails<SSElement> details) {
          ref.read(canvasObjectsProvider.notifier).onAcceptWithDetails(
                newData: details,
                parentElement: _newElement,
              );
          ref.read(_willAcceptedProvider.state).state = false;
        },
        onWillAccept: (SSElement? _map) {
          ref.read(_willAcceptedProvider.state).state = true;
          return true;
        },
        onLeave: (SSElement? _map) {
          ref.read(_willAcceptedProvider.state).state = false;
        },
      ),
    );
  }
}

class _SizedContainer extends ConsumerWidget {
  final SSElement _newElement;
  final double _width, _height;
  final double? opacity;
  final StateProvider<bool> _willAcceptedProvider;

  const _SizedContainer(
    this._newElement,
    this._willAcceptedProvider,
    this._width,
    this._height, {
    this.opacity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _type = _newElement.layoutType.toLayoutType!;
    final _willAccepted = ref.watch(_willAcceptedProvider);
    final _isSelected = ref.watch(selectedUuid) == _newElement.uuid;
    final _willHighlight = _willAccepted || _isSelected;

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        border: Border.all(
          color: _willHighlight ? SSColor.primary : Colors.black,
          width: _willHighlight ? 5.0 : 1.0,
        ),
        color: _willHighlight
            ? SSColor.white
            : opacity != null
                ? SSColor.offWhite.withOpacity(opacity!)
                : Colors.green,
      ),
      child: Center(
        child: Icon(_type.iconData),
        // todo: 表現の方法を検討する text or icon
        // child: Text(type.value),
      ),
    );
  }
}
