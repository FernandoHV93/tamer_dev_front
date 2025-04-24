import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData defaultTheme = ThemeData(
    primaryColor: Colors.blueAccent,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.w400,
          color: Colors.blueAccent),
      bodyLarge: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w100),
      bodyMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100),
      bodySmall: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100),
    ),
  );
}
