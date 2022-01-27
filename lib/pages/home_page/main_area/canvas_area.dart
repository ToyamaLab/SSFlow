// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class CanvasArea extends ConsumerWidget {
  const CanvasArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(mainAreaSize).width;
    final _height = ref.watch(mainAreaSize).height;
    final _canvasObjects = ref.watch(canvasObjectsProvider);
    final _undoEnabled = ref.watch(undoProvider.notifier).isEnabled;
    final _redoEnabled = ref.watch(redoProvider.notifier).isEnabled;

    return Container(
      width: _width,
      height: _height,
      color: SSColor.darkGrey,
      child: Stack(
        children: [
          Positioned(
            top: 10.0,
            right: 10.0,
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => ref.read(ssElementsProvider.notifier).clear(),
            ),
          ),
          DragTarget<SSElement>(
            builder: (
              BuildContext context,
              List<Object?> accepted,
              List<dynamic> rejectedData,
            ) {
              return Center(
                child: Container(
                  width: _width * 0.8,
                  height: _width * 0.5,
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _canvasObjects),
                  ),
                ),
              );
            },
            onAcceptWithDetails: (DragTargetDetails<SSElement> details) {
              ref.read(canvasObjectsProvider.notifier).onAcceptWithDetails(
                    newData: details,
                    parentElement: null,
                  );
            },
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Row(
              children: [
                // Undo button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: SSColor.white,
                  disabledColor: SSColor.grey,
                  onPressed: _undoEnabled
                      ? () {
                          ref.watch(undoProvider.notifier).undo();
                        }
                      : null,
                ),
                // Redo button
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  color: SSColor.white,
                  disabledColor: SSColor.grey,
                  onPressed: _redoEnabled
                      ? () {
                          ref.watch(redoProvider.notifier).redo();
                        }
                      : null,
                ),
              ],
            ),
          ),
          /*// parent info for debug
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                Column(
                  children: [
                    Text('Child Object Info'),
                    Text('$childId'),
                    Text(childObject),
                  ],
                ),
                Column(
                  children: [
                    Text('Parent Object Info'),
                    Text('$parentId'),
                    Text(parentObject),
                  ],
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
