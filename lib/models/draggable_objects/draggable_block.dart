// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableBlock extends DraggableObject {
  const SSDraggableBlock({Key? key})
      : super(
          L.block,
          key: key,
        );
}
