import 'package:flutter/material.dart';

class AppTheme {
  static const _void = Color(0xFF060612);
  static const _text = Color(0xFFEEF0FF);
  static const _cyan = Color(0xFF00F5D4);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _void,
      colorScheme: const ColorScheme.dark(
        primary: _cyan,
        surface: _void,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: _text,
          fontFamily: 'sans-serif',
        ),
      ),
      fontFamily: 'sans-serif',
    );
  }
}
