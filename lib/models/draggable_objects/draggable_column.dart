// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableColumn extends DraggableObject {
  const SSDraggableColumn({Key? key})
      : super(
          L.column,
          width: 50.0,
          key: key,
        );
}
