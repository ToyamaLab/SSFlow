// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/draggable_object.dart';

class SSDraggableFunction extends DraggableObject {
  const SSDraggableFunction({Key? key})
      : super(
          L.function,
          key: key,
        );
}
