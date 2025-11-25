// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';

const Color primaryColor = Color(0xFF096835);
const Color mintGrean = Color(0xFF83A887);
const Color backgroundColor = Color(0xFFF8FAF9);
const Color noFocused = Color(0xFFD9D9D9);

class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor,
      selectionColor: primaryColor.withOpacity(0.3),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        elevation: 0.0,
        shadowColor: Colors.transparent,
      ),
    ),

    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.black87),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: noFocused, width: 1.0.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: noFocused, width: 1.0.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: primaryColor, width: 1.0.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: Colors.red, width: 1.0.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(color: Colors.red, width: 1.0.w),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
