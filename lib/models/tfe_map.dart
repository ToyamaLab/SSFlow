/// {
/// 'id': 1,
/// 'parent': 0,
/// 'after': null,
/// 'layout-type': 'repeat-vertical',
/// 'body': null,
/// }
/// のようなもの。widget treeとしてはこれらをListにしてまとめておく
///
/// SuperSQLにおける["table.id", "table.name"]!は以下のように表現する
/// [
///   {
///     'id': 1,'parent': 0,'after': null,
///     'layout-type': 'repeat-vertical','body': null
///   },
///   {
///     'id': 2,'parent': 1,'after': null,
///     'layout-type': 'row','body': null
///   },
///   {
///     'id': 3,'parent': 2,'after': null,
///     'layout-type': 'table-data','body': 'table.id'
///   },
///   {
///     'id': 4,'parent': 2,'after': 3,
///     'layout-type': 'table-data','body': 'table.name'
///   }
/// ]
typedef TFEMap = Map<String, dynamic>;
