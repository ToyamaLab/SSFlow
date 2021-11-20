import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ssflow/providers/_providers.dart';

import 'pages/home_page/home_page.dart';

void main() {
  runApp(ProviderScope(child: SSFlow()));
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
      home: Scaffold(
        body: HomePage(),
      ),
      builder: EasyLoading.init(),
    );
  }
}
