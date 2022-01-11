// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';

final textDataController = StateNotifierProvider.autoDispose<_EditingController,
    TextEditingController>(
  (ref) => _EditingController(ref.watch),
);
final dbTableController = StateNotifierProvider.autoDispose<_EditingController,
    TextEditingController>(
  (ref) => _EditingController.table(ref.watch),
);
final dbColumnController = StateNotifierProvider.autoDispose<_EditingController,
    TextEditingController>(
  (ref) => _EditingController.column(ref.watch),
);

class _EditingController extends StateNotifier<TextEditingController> {
  final Reader _read;
  _EditingController(this._read) : super(TextEditingController(text: '')) {
    if (_read(selectedUuid).isNotEmpty) {
      final _selectedElement = _read(selectedSSElementProvider(_read));
      update(_selectedElement.body);
    }
  }

  // [L.tableData]の場合は、bodyが'table-name.column-name'となる
  // todo table名及びcolumn名に'.'が入る場合を考慮して、[SSElement.body]のデータ形式を変更するか検討
  _EditingController.table(this._read)
      : super(TextEditingController(text: '')) {
    if (_read(selectedUuid).isNotEmpty) {
      final _selectedElement = _read(selectedSSElementProvider(_read));
      update(_selectedElement.body.split('.').first);
    }
  }

  _EditingController.column(this._read)
      : super(TextEditingController(text: '')) {
    if (_read(selectedUuid).isNotEmpty) {
      final _selectedElement = _read(selectedSSElementProvider(_read));
      update(_selectedElement.body.split('.').last);
    }
  }

  void update(String newText) => state = TextEditingController(text: newText);
}
