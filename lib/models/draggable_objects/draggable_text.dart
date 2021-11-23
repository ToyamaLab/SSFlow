// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
import 'package:ssflow/models/_models.dart';

class SSDraggableText extends DraggableObject {
  const SSDraggableText({Key? key})
      : super(
          L.text,
          key: key,
        );
}
