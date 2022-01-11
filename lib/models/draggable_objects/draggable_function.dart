// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableFunction extends DraggableObject {
  const SSDraggableFunction({Key? key})
      : super(
          L.function,
          body: 'func()',
          key: key,
        );
}
