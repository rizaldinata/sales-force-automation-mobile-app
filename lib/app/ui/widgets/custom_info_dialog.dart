import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';

enum DialogType { success, error }

class CustomInfoDialog extends StatefulWidget {
  final String title;
  final String message;
  final DialogType type;
  final VoidCallback? onPressed;
  final String buttonText;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onPressed,
    this.buttonText = "OK",
  });

  @override
  State<CustomInfoDialog> createState() => _CustomInfoDialogState();
}

class _CustomInfoDialogState extends State<CustomInfoDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = widget.type == DialogType.success;
    final Color mainColor = isSuccess ? primaryColor : Colors.red;
    final IconData icon = isSuccess ? Icons.check_circle : Icons.error_outline;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(28.w),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 24.0,
              offset: Offset(0.0, 12.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48.sp, color: mainColor),
              ),
            ),
            SizedBox(height: AppSpacing.spacing24),

            // Title
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3.h,
              ),
            ),
            SizedBox(height: AppSpacing.spacing12),

            // Message
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                height: 1.5.h,
              ),
            ),
            SizedBox(height: AppSpacing.spacing32),

            // Button
            SizedBox(
              width: double.infinity,
              height: AppSizes.inputHeight,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  if (widget.onPressed != null) {
                    widget.onPressed!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
