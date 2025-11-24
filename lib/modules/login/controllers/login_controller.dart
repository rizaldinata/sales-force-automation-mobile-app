import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/core/utils/app_dialog.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  @override
  void onClose() {
    usernameC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    FocusNode? currentFocus = FocusManager.instance.primaryFocus;

    isPasswordVisible.value = !isPasswordVisible.value;

    if (currentFocus != null && currentFocus.context != null) {
      currentFocus.unfocus();

      FocusScope.of(currentFocus.context!).requestFocus(currentFocus);
    }
  }

  Future<void> login() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      try {
        isLoading.value = true;

        await Future.delayed(const Duration(seconds: 2));

        Get.offAllNamed(AppRoutes.home);
      } catch (e) {
        Get.snackbar(
          "Error",
          "Username atau password salah.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> loginManual() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      try {
        isLoading.value = true;

        await Future.delayed(const Duration(seconds: 1));

        if (usernameC.text == 'admin' && passwordC.text == '123456') {
          Get.offAllNamed(AppRoutes.home);

          AppDialog.showSuccess(
            title: "Login Berhasil",
            message: "Selamat datang kembali, Admin!",
            onPressed: () {
              Get.back();
            },
          );
        } else {
          AppDialog.showError(
            title: "Gagal Masuk",
            message: "Username atau password salah.\nSilakan coba lagi.",
          );
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}
