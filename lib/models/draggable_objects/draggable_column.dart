// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/draggable_object.dart';

class SSDraggableColumn extends DraggableObject {
  SSDraggableColumn({Key? key}) : super(L.column, width: 50.0);
}
