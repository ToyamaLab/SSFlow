// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/draggable_object.dart';

class SSDraggableRepeatHorizontal extends DraggableObject {
  SSDraggableRepeatHorizontal({Key? key})
      : super(L.repeatHorizontal, height: 50);
}
