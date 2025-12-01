// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';

class MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const MonthPickerDialog({super.key, required this.initialDate});

  @override
  State<MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 24.0,
              offset: const Offset(0.0, 12.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pilih Bulan",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _selectedYear--),
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: primaryColor,
                      size: 28.sp,
                    ),
                    splashRadius: 24,
                  ),
                  Text(
                    "$_selectedYear",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 1.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _selectedYear++),
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      color: primaryColor,
                      size: 28.sp,
                    ),
                    splashRadius: 24,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.6,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final int monthIndex = index + 1;

                final isSelected =
                    monthIndex == widget.initialDate.month &&
                    _selectedYear == widget.initialDate.year;

                final monthName = DateFormat(
                  'MMM',
                  'id_ID',
                ).format(DateTime(2024, monthIndex));

                return InkWell(
                  onTap: () {
                    Get.back(result: DateTime(_selectedYear, monthIndex));
                  },
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey[300]!),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      monthName,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
