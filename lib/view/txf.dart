import 'package:flutter/material.dart';

class Txf extends StatelessWidget {
  final height;
  final width;
  final label;
  final hint;
  final color;
  final prefix;
  final suffix;
  final padding;

  const Txf(
      {Key? key,
      this.height,
      this.width,
      this.label,
      this.hint,
      this.color,
      this.prefix,
      this.suffix,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: padding,
          hintText: hint,
          labelText: label,
          prefixIcon: prefix,
          suffixIcon: suffix,
          filled: true,
          fillColor: color,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
