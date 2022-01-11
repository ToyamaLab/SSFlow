// ignore_for_file: prefer_const_constructors

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';

final draggableObjectsProvider =
    StateNotifierProvider<DraggableObjectsController, List<Widget>>(
  (ref) => DraggableObjectsController(),
);

class DraggableObjectsController extends StateNotifier<List<Widget>> {
  DraggableObjectsController()
      : super(const [
          SSDraggableColumn(),
          SSDraggableRow(),
          SSDraggableRepeatVertical(),
          SSDraggableRepeatHorizontal(),
          SSDraggableText(),
          SSDraggableFunction(),
          SSDraggableTableData(),
          SSDraggableBlock(),
        ]);

  void reload() {
    // todo #85 DraggableObjectsControllerのreloadでは必要な分だけ更新するようにする
    state = [
      SSDraggableColumn(),
      SSDraggableRow(),
      SSDraggableRepeatVertical(),
      SSDraggableRepeatHorizontal(),
      SSDraggableText(),
      SSDraggableFunction(),
      SSDraggableTableData(),
      SSDraggableBlock(),
    ];
  }
}
