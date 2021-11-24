// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableRow extends DraggableObject {
  const SSDraggableRow({Key? key})
      : super(
          L.row,
          height: 50.0,
          key: key,
        );
}
