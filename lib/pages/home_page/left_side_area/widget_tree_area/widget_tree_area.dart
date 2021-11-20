// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/models/tfe_map.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

/// widget treeを表示する場所
class WidgetTreeArea extends ConsumerWidget {
  const WidgetTreeArea({
    Key? key,
  }) : super(key: key);

  // TODO: #9 2段目以降はchildrenが1つになる
  Widget expansionTileChildren({
    required List<TFEMap> map,
    TFEMap? parent,
    int? parentID,
  }) {
    // todo if文の中に入ることはあるのか不明
    if (parentID == null && (parent != null && parent.isEmpty))
      return Container();

    List<TFEMap> _remains = [...map];
    List<Widget> _parentChildren = <Widget>[];
    Widget _childTile = Container();

    map.where((map) => map['parent'] == parentID).forEach((element) {
      List<Widget> _children = <Widget>[];
      _remains.remove(element);
      _children.add(
        expansionTileChildren(
          map: _remains,
          parentID: element['id'],
        ),
      );

      _childTile = ExpansionTile(
        title: Text(' -> ${element['layout-type']}'),
        children: _children,
      );
      _parentChildren.add(_childTile);
    });

    if (parent != null && parent.isNotEmpty) {
      return ExpansionTile(
        title: Text(parent['layout-type']),
        children: _parentChildren,
      );
    } else {
      return _childTile;
    }
  }

  List<Widget> buildExpansionTiles(List<TFEMap> map) {
    List<Widget> expansionTiles = <Widget>[];
    List<TFEMap> remains = [...map];
    int? _parentID = -1;

    while (_parentID != null) {
      final TFEMap _parent = remains.firstWhere(
            (map) => map['parent'] == null,
        orElse: () => Map(),
      );

      remains.remove(_parent);

      /// if _parent is empty Map, then _parentID is null? or error
      if (_parent.isEmpty) {
        _parentID = null;
      } else {
        _parentID = _parent['id'];
      }

      expansionTiles.add(expansionTileChildren(
        map: remains,
        parentID: _parentID,
        parent: _parent,
      ));
    }
    return expansionTiles;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = 2 * ref.watch(leftSideAreaSize).width / 3.0;

    return Material(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(
              color: SSColor.grey,
              width: 1.0,
            ),
          ),
          color: SSColor.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // TODO fix this ref: #23
          // children: buildExpansionTiles(CanvasAreaState.treeNodes),
          children: buildExpansionTiles([]),
        ),
      ),
    );
  }
}
