import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF096835);
const Color backgroundColor = Color(0xFFEDF4EE);
const Color noFocused = Color(0xFFD9D9D9);

const double paddingRightSuffixIcon = 12.0;

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,

    // Warna Cursor
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor,
      selectionColor: primaryColor.withOpacity(0.3),
    ),

    // Tema Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: noFocused, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: noFocused, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: primaryColor, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      hintStyle: TextStyle(color: noFocused),
    ),
  );
}
