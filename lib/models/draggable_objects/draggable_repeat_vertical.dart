// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableRepeatVertical extends DraggableObject {
  const SSDraggableRepeatVertical({Key? key})
      : super(
          L.repeatVertical,
          width: 50.0,
          key: key,
        );
}
