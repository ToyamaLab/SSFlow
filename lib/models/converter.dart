import 'package:ssflow/models/tfe_map.dart';
import 'package:ssflow/pages/home_page/canvas_area/canvas_area.dart';

/// TFEMapとレイアウト、TFEMapとSSQLのコードを変換するためのクラス
class Converter {
  Converter();

  /// それぞれのアイテムにIDをつける
  int _maxID = 0;

  int get nextID => ++_maxID;

  set maxID(int id) => this._maxID = id;

  TFEMap createTFE({
    required String layoutType,
    int? id,
    int? parent,
    int? after,
    String? body,
  }) {
    TFEMap newTFE = {
      'id': id ?? nextID,
      'layout-type': layoutType,
      'parent': parent,
      'after': after,
      'body': body,
    };
    return newTFE;
  }

  TFEMap appendTFE({
    required String layoutType,
    int? parent,
    int? after,
    String? body,
  }) {
    TFEMap newTfe = createTFE(
      layoutType: layoutType,
      parent: parent,
      after: after,
      body: body,
    );
    CanvasAreaState.widgetTree.add(newTfe);
    return newTfe;
  }
}
