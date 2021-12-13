// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod/riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/ss_elements.dart';
import 'package:ssflow/utils/constants/_constants.dart';

final widgetTreeProvider =
    StateNotifierProvider<WidgetTreeController, List<Widget>>(
  (ref) => WidgetTreeController(ref.read),
);

class WidgetTreeController extends StateNotifier<List<Widget>> {
  final Reader _read;
  WidgetTreeController(this._read) : super([]);

  void clear() => state = <Widget>[];

  void generate() {
    final TreeNode<SSElement> node =
        _read(ssElementsProvider.notifier).treeNode;
    state = buildExpansionTile(node);
  }

  List<Widget> buildExpansionTile(
    TreeNode<SSElement> node, {
    String offset = '',
  }) {
    List<Widget> result = <Widget>[];
    node.children.forEach((String uuid, TreeNode<SSElement> t) {
      if (t.data != null) {
        final tile = t.children.isEmpty
            ? ListTile(
                title: Text(
                  offset + t.data!.layoutType,
                  style: TextStyle(color: SSColor.white),
                ),
                selected: true,
                tileColor: SSColor.black,
              )
            : ExpansionTile(
                title: Text(offset + t.data!.layoutType),
                children: buildExpansionTile(t, offset: '    ' + offset),
                backgroundColor: SSColor.darkGrey,
                textColor: SSColor.white,
                iconColor: SSColor.white,
                collapsedBackgroundColor: SSColor.black,
                collapsedTextColor: SSColor.white,
                collapsedIconColor: SSColor.white,
              );
        result.add(tile);
      }
    });
    return result;
  }
}
