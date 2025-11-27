import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/core/utils/app_dialog.dart';
import 'package:salesforce_app/app/data/services/auth_service.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

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
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        final bool isSuccess = await _authService.login(
          usernameC.text,
          passwordC.text,
        );

        if (isSuccess) {
          Get.offAllNamed(AppRoutes.home);

          AppDialog.showSuccess(
            title: "Login Berhasil",
            message: "Selamat datang kembali, Admin!",
            onPressed: () => Get.back(),
          );
        } else {
          AppDialog.showError(
            title: "Gagal Masuk",
            message: "Username atau password salah.\nSilakan coba lagi.",
          );
        }
      } catch (e) {
        AppDialog.showError(
          title: "Error",
          message: "Terjadi kesalahan sistem: $e",
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
