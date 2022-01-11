// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableRepeatHorizontal extends DraggableObject {
  const SSDraggableRepeatHorizontal({Key? key})
      : super(
          L.repeatHorizontal,
          height: 50,
          key: key,
        );
}
