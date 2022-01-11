// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

extension NavigatorStateEx on NavigatorState {
  BuildContext get descendantContext => overlay!.context;
}
