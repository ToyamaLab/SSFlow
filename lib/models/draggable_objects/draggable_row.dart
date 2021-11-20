// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/draggable_object.dart';

class SSDraggableRow extends DraggableObject {
  SSDraggableRow({Key? key}) : super(L.row, height: 50.0);
}
