// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/models/draggable_objects/_draggable_objects.dart';

final draggableObjectsProvider =
    StateNotifierProvider<DraggableObjectsController, List<Widget>>((ref) {
  return DraggableObjectsController();
});

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
    state = const [
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
