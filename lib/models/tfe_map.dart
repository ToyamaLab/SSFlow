/// {'<layout type>': {'<layout type>': [<element>, <element>]}}のようなもの
///
/// SuperSQLにおける["table.id", "table.name"]!は以下のように表現する
/// {'repeat-vertical':
///   {'row':
///     [{'table-data': 'table.id'}, {'table-data': 'table.name'},]
///   }
/// }
typedef TFEMap = Map<String, dynamic>;
