import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final VoidCallback? onFieldSubmitted;
  final bool autofocus;

  const PrimaryTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      textInputAction: textInputAction,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      onFieldSubmitted: onFieldSubmitted == null
          ? null
          : (_) => onFieldSubmitted!(),
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
      validator: validator,
    );
  }
}
