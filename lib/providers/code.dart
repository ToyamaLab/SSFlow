// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';
import 'package:ssflow/providers/_providers.dart';

final codeProvider = StateNotifierProvider<CodeController, String>(
  (ref) => CodeController(ref.read),
);

class CodeController extends StateNotifier<String> {
  final Reader _read;
  CodeController(this._read) : super('');

  void clear() => state = '';

  void generate() {
    final TreeNode<SSElement> node =
        _read(ssElementsProvider.notifier).treeNode;
    _read(queryTableProvider).clear();
    state = _generateSSQL(node);
  }

  void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    final _context = _read(navigatorKeyProvider).currentContext!;
    const _snackBar = SnackBar(
      content: Text('Copied!'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(_context).showSnackBar(_snackBar);
  }

  String _generateSSQL(TreeNode<SSElement> node) {
    String _query = _mediaPart() + _queryPart(node) + _dbPart();
    return _query.replaceAll(RegExp('\n+'), '\n').replaceAll(RegExp(' +'), ' ');
  }

  String _mediaPart() => 'GENERATE HTML\n';

  String _dbPart() {
    final _table = _read(queryTableProvider).join(', ');
    return '\nFROM $_table';
  }

  String _queryPart(
    TreeNode<SSElement> node, {
    String separator = '',
  }) {
    String result = '';
    if (node.data != null &&
        node.data!.layoutType.toLayoutType! == L.tableData) {
      _read(queryTableProvider.notifier).add(node.data!.body.split('.').first);
    }

    if (node.children.isEmpty) {
      return _extractData(node.data!) + separator;
    }

    node.children.forEach((String uuid, TreeNode<SSElement> t) {
      String before = '', after = '';
      if (t.data != null) {
        switch (t.data!.layoutType.toLayoutType) {
          case LayoutType.column:
            separator = ' ! ';
            break;
          case LayoutType.row:
            separator = ' , ';
            break;
          case LayoutType.repeatVertical:
            before += '[ ';
            after = ' ]!\n' + after;
            break;
          case LayoutType.repeatHorizontal:
            before += '[ ';
            after = ' ],\n' + after;
            break;
          case LayoutType.block:
            before += '{ ';
            after = ' }' + after;
            break;
          default:
            break;
        }
        if (t.children.isNotEmpty) {
          String _generated = _queryPart(t, separator: separator);
          // ここでseparatorの処理をしないと、{}の中などに残ってしまう
          if (_endWithSeparator(_generated, separator)) {
            _generated = _removeSeparator(_generated, separator);
          }
          result += before + _generated + after;
        } else {
          result += _queryPart(t, separator: separator);
        }
      }
    });
    return result;
  }

  String _extractData(SSElement e) {
    final L type = e.layoutType.toLayoutType!;
    if (type.isLayoutElement()) {
      return '';
    } else {
      return e.body ??= type.toString();
    }
  }

  bool _endWithSeparator(String str, String separator) {
    final _lastIndex = str.lastIndexOf(separator);
    final _lengthWithoutSeparator = str.length - separator.length;
    return _lastIndex == _lengthWithoutSeparator;
  }

  String _removeSeparator(String str, String separator) {
    return str.substring(0, str.length - separator.length);
  }
}

final queryTableProvider =
    StateNotifierProvider<_QueryDBController, List<String>>(
  (ref) => _QueryDBController(),
);

class _QueryDBController extends StateNotifier<List<String>> {
  _QueryDBController() : super([]);

  void add(String table) {
    if (!state.contains(table)) {
      state.add(table);
    }
  }

  void clear() => state = [];
}
