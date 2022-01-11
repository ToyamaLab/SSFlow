// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

void main() {
  runApp(const ProviderScope(child: SSFlow()));
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    setWindowTitle('SSFlow');
    setWindowMinSize(const Size(800, 600));
  }
}

class SSFlow extends ConsumerWidget {
  const SSFlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSFlow',
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
              bodyText1: const TextStyle(fontSize: 20),
              bodyText2: const TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            )
            .apply(
              bodyColor: SSColor.offWhite,
              displayColor: SSColor.offWhite,
            ),
      ),
      navigatorKey: ref.watch(navigatorKeyProvider),
      home: Builder(
        builder: (context) {
          return ProviderScope(
            overrides: [
              windowSize.overrideWithValue(
                StateController(MediaQuery.of(context).size),
              ),
            ],
            child: const Scaffold(
              body: HomePage(),
            ),
          );
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
