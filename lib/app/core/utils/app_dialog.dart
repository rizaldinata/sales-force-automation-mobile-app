import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/ui/widgets/custom_info_dialog.dart';

class AppDialog {
  static void showSuccess({
    required String title,
    required String message,
    VoidCallback? onPressed,
  }) {
    Get.dialog(
      CustomInfoDialog(
        title: title,
        message: message,
        type: DialogType.success,
        onPressed: onPressed,
      ),
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeOutCubic,
    );
  }

  static void showError({required String title, required String message}) {
    Get.dialog(
      CustomInfoDialog(
        title: title,
        message: message,
        type: DialogType.error,
        buttonText: "Coba Lagi",
      ),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeOutCubic,
    );
  }
}
