import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: Color(0xffEFF5FE),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    // Insert anything else here
  );
}