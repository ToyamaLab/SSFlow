import 'package:flutter/material.dart';

class AttributeArea extends StatelessWidget {
  AttributeArea(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      color: Colors.green,
    );
  }
}
