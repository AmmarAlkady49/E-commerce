import 'package:flutter/material.dart';

class FontHelper {
  static TextStyle fontText(
      {required double size,
      required FontWeight weight,
      required Color color}) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: 'cairo',
    );
  }
}
