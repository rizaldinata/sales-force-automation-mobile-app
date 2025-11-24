import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtension on BuildContext {
  // Quick access theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Screen size
  double get screenWidth => 1.sw;
  double get screenHeight => 1.sh;

  // Keyboard
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  // Unfocus
  void unfocus() => FocusScope.of(this).unfocus();
}
