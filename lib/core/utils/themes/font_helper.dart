import 'package:flutter/material.dart';

class FontHelper {
  static TextStyle fontText({
    required BuildContext context,
    required double size,
    required FontWeight weight,
    required Color color,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    bool? isItalic,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      shadows: shadows,
      fontStyle: isItalic == true ? FontStyle.italic : null,
      fontFamily:
          Localizations.localeOf(context).languageCode == 'en' ? null : 'cairo',
      decoration: decoration,
      decorationColor: Colors.white,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 2.0,
    );
  }
}
