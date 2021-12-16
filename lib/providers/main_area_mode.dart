// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';

final mainAreaMode = StateNotifierProvider<_MainAreaController, MainAreaMode>(
  (ref) => _MainAreaController(),
);

class _MainAreaController extends StateNotifier<MainAreaMode> {
  _MainAreaController() : super(MainAreaMode.canvas);

  void update(MainAreaMode newMode) => state = newMode;

  Future<void> launchUrl(String urlString) async {
    if (!await launch(urlString)) {
      throw 'Could not launch $urlString';
    }
  }
}
