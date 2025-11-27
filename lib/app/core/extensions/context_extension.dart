import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  double get screenWidth => 1.sw;
  double get screenHeight => 1.sh;

  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  void unfocus() => FocusScope.of(this).unfocus();
}
