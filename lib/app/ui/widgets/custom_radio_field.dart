// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';

class CustomRadioField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final Function(String) onChanged;

  const CustomRadioField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: items.map((item) {
              final isSelected = selectedValue == item;

              final double boxWidth = (1.sw - 48.w - 12.w) / 2;

              return InkWell(
                onTap: () => onChanged(item),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: boxWidth,
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryColor.withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: isSelected
                          ? primaryColor
                          : const Color(0xFFD9D9D9),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected ? primaryColor : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
