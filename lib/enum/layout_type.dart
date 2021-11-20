// Flutter imports:
import 'package:flutter/material.dart';

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

  static final Map<L, IconData> typeIcons = {
    L.column: Icons.arrow_downward_sharp,
    L.row: Icons.arrow_forward_sharp,
    L.repeatVertical: Icons.vertical_align_bottom_sharp,
    L.repeatHorizontal: Icons.double_arrow_sharp,
    L.text: Icons.text_fields,
    L.function: Icons.functions,
    L.tableData: Icons.table_rows_rounded,
    L.block: Icons.check_box_outline_blank_sharp,
  };

  String get value => typeNames[this]!;

  IconData get iconData => typeIcons[this]!;

  bool isLayoutElement() {
    switch (this) {
      case LayoutType.column:
      case LayoutType.row:
      case LayoutType.repeatVertical:
      case LayoutType.repeatHorizontal:
      case LayoutType.block:
        return true;
      default:
        return false;
    }
  }
}

extension LayoutTypeStringExtension on String {
  L? get toLayoutType {
    L? type;
    for (var typeName in LayoutTypeExtension.typeNames.entries) {
      if (typeName.value == this) {
        type = typeName.key;
        break;
      }
    }

    return type;
  }
}
