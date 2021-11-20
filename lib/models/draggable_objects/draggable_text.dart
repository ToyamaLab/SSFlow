// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/layout_type.dart';
import 'package:ssflow/models/draggable_object.dart';

class SSDraggableText extends DraggableObject {
  const SSDraggableText({Key? key})
      : super(
          L.text,
          key: key,
        );
}
