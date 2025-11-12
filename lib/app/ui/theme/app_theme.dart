import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF096835);
const Color backgroundColor = Color(0xFFEDF4EE);

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,

    // Tema Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    ),

    // Tema Teks
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
