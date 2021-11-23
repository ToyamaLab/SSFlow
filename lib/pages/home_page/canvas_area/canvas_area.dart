// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

class CanvasArea extends ConsumerWidget {
  const CanvasArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(windowSize).width / 4 * 1.5;
    final _height = ref.watch(windowSize).height * 0.9;
    final _size = Size(_width, _height);
    final _canvasObjects = ref.watch(canvasObjectsProvider);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(canvasAreaSize.notifier).init(context, size: _size),
    );

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
                    details: details,
                    thisData: null,
                  );
            },
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
