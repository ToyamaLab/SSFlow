// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/pages/home_page/left_side_area/draggable_object_area.dart';
import 'package:ssflow/pages/home_page/left_side_area/widget_tree_area.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

final _selectedIndex = StateNotifierProvider<_SelectedIndexController, int>(
  (ref) => _SelectedIndexController(),
);

class _SelectedIndexController extends StateNotifier<int> {
  _SelectedIndexController() : super(0);

  void update(int newIndex) => state = newIndex;
}

/// Widget Treeを表示しておく
class LeftSideArea extends ConsumerWidget {
  const LeftSideArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(windowSize).width / 4 * 1.5;
    final _height = ref.watch(windowSize).height * 0.9;
    final _index = ref.watch(_selectedIndex);
    final _size = Size(_width, _height);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ref.read(leftSideAreaSize.notifier).init(context, size: _size),
    );

    return Material(
      child: Container(
        width: _width,
        height: _height,
        color: SSColor.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1 * _width / 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home_filled),
                    color: _index == 0 ? SSColor.primary : Colors.grey,
                    hoverColor: Colors.deepOrange,
                    onPressed: () =>
                        ref.read(_selectedIndex.notifier).update(0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder),
                    color: _index == 1 ? SSColor.primary : Colors.grey,
                    hoverColor: Colors.deepOrange,
                    onPressed: () =>
                        ref.read(_selectedIndex.notifier).update(1),
                  ),
                ],
              ),
            ),
            const [
              WidgetArea(),
              WidgetTreeArea(),
            ][_index],
          ],
        ),
      ),
    );
  }
}
