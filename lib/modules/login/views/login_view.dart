import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/widgets/primary_button.dart';
import 'package:salesforce_app/app/ui/widgets/primary_text_form_field.dart';
import 'package:salesforce_app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: -0.1,
                          child: Text(
                            'SALESFORCE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'LuckiestGuy',
                              fontSize: 48.sp,
                              fontWeight: FontWeight.w900,
                              color: primaryColor,
                              letterSpacing: 1.5.w,
                              height: 1.2.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bagian Form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Selamat datang di aplikasi Salesforce",
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: AppSpacing.spacing8),
                        Text(
                          "Silahkan masuk untuk melanjutkan",
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 13.sp,
                            color: Colors.grey[600],
                          ),
                        ),

                        SizedBox(height: AppSpacing.spacing36),

                        // Form Username
                        PrimaryTextFormField(
                          controller: controller.usernameC,
                          hintText: "Username",
                          autofocus: false,
                          validator: (value) => (value == null || value.isEmpty)
                              ? "Username wajib diisi"
                              : null,
                        ),

                        SizedBox(height: AppSpacing.spacing12),

                        // Form Password
                        Obx(
                          () => PrimaryTextFormField(
                            controller: controller.passwordC,
                            hintText: "Password",
                            obscureText: !controller.isPasswordVisible.value,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? "Password wajib diisi"
                                : null,
                            suffixIcon: IconButton(
                              padding: EdgeInsets.only(right: 24),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey[600],
                                size: 20.sp,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),

                        SizedBox(height: AppSpacing.spacing24),

                        // Tombol Masuk
                        Obx(
                          () => PrimaryButton(
                            text: "MASUK",
                            onPressed: controller.login,
                            isLoading: controller.isLoading.value,
                          ),
                        ),

                        SizedBox(height: AppSpacing.spacing12),

                        Center(
                          child: Text(
                            "Versi 1.0.0",
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),

                        SizedBox(height: AppSpacing.spacing36),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
