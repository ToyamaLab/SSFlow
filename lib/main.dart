// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/pages/_pages.dart';
import 'package:ssflow/providers/_providers.dart';

void main() {
  runApp(const ProviderScope(child: SSFlow()));
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
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: ref.watch(navigatorKeyProvider),
      home: const Scaffold(
        body: HomePage(),
      ),
      builder: EasyLoading.init(),
    );
  }
}
