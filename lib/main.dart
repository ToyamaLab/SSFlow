import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'pages/home_page/home_page.dart';

void main() {
  runApp(SSFlow());
}

class SSFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSFlow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: HomePage(),
      ),
      builder: EasyLoading.init(),
    );
  }
}
