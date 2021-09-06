import 'package:ssflow/models/tfe_map.dart';

/// TFEMapとレイアウト、TFEMapとSSQLのコードを変換するためのクラス
class Converter {
  Converter();

  List<TFEMap> _widgetTree = <TFEMap>[];

  /// それぞれのアイテムにIDをつける
  int _maxID = 0;

  List<TFEMap> get widgetTree => _widgetTree;

  int get maxID => _maxID;

  void setWidgetTree(List<TFEMap> widgetTree) {
    this._widgetTree = widgetTree;
  }

  int nextID() {
    _maxID++;
    return maxID;
  }

  void appendTFE({
    required int id,
    required int parent,
    required String layoutType,
    int? after,
    String? body,
  }) {
    TFEMap newTfe = {
      'id': id,
      'parent': parent,
      'after': after,
      'layout-type': layoutType,
      'body': body,
    };
    widgetTree.add(newTfe);
  }
}
