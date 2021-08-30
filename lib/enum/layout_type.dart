/// LayoutType
typedef L = LayoutType;

enum LayoutType {
  column,
  row,
  repeatVertical,
  repeatHorizontal,
  text,
  function,
  tableData,
  block,
}

extension LayoutTypeExtension on L {
  static final Map<L, String> typeNames = {
    L.column: 'column',
    L.row: 'row',
    L.repeatVertical: 'repeat-vertical',
    L.repeatHorizontal: 'repeat-horizontal',
    L.text: 'text',
    L.function: 'function',
    L.tableData: 'table-data',
    L.block: 'block',
  };

  String get value => typeNames[this]!;
}

extension LayoutTypeStringExtension on String {
  L? get toLayoutType {
    L? type;
    LayoutTypeExtension.typeNames.entries.forEach((element) {
      if (element.value == this) {
        type = element.key;
        return;
      }
    });

    return type;
  }
}
