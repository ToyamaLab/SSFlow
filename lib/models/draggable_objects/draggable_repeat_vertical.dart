// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/draggable_object.dart';

class SSDraggableRepeatVertical extends DraggableObject {
  const SSDraggableRepeatVertical({Key? key})
      : super(
          L.repeatVertical,
          width: 50.0,
          key: key,
        );
}
