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
import 'package:ssflow/utils/constants/_constants.dart';

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
    DragTargetDetails<SSElement>? details,
    SSElement? thisData,
  }) {
    if (details == null) {
      return;
    }

    if (!_canAddObject(thisData?.layoutType)) {
      return;
    }

    SSElement newElement = details.data;
    newElement.parentUuid = thisData?.uuid;
    _read(ssElementsProvider.notifier).add(newElement);
    final treeNodes = _read(ssElementsProvider.notifier).treeNode;
    logger.info(treeNodes);
  }

  bool _canAddObject(String? layoutType) {
    if (layoutType == null) {
      // `parent = null`はparentがrootの意味
      return true;
    }

    final L type = layoutType.toLayoutType!;
    if (type.isLayoutElement()) {
      return true;
    } else {
      EasyLoading.showError('このタイプのオブジェクトには追加できません');
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
      onTap: () {
        logger.info('onTap newElement: $_newElement');
      },
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
          );
        },
        onAcceptWithDetails: (DragTargetDetails<SSElement> details) {
          ref.read(canvasObjectsProvider.notifier).onAcceptWithDetails(
                details: details,
                thisData: _newElement,
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

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        border: Border.all(
          color: _willAccepted ? SSColor.primary : Colors.black,
          width: _willAccepted ? 5.0 : 1.0,
        ),
        color: _willAccepted
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
