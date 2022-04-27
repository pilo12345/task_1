import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  final text;
  final double size;
  final fontWeight;
  final fontFamily;
  final color;
  final decoration;

  Texts(
      {this.text,
      required this.size,
      this.fontWeight,
      this.fontFamily,
      this.color,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            decoration: TextDecoration.none,
            color: color,
            fontWeight: fontWeight,
            fontSize: size,
            fontFamily: fontFamily));
  }
}
