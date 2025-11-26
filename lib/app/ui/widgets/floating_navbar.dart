// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';

class FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      height: 70.h,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(Icons.home_rounded, 0),
          _buildItem(Icons.flight_takeoff_rounded, 1),
          _buildItem(Icons.person_rounded, 2),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutQuint,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutBack,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 350),
                opacity: isSelected ? 1.0 : 0.6,
                child: Icon(icon, color: Colors.white, size: 24.sp),
              ),
            );
          },
        ),
      ),
    );
  }
}
