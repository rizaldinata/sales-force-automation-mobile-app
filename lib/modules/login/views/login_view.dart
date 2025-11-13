import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 48,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Logo Aplikasi
                          SizedBox(height: 24.0),
                          Image.asset('assets/images/logo_salesforce.png'),
                          SizedBox(height: 24.0),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Teks Sambutan
                              Text(
                                "Selamat datang di aplikasi Salesforce",
                                textAlign: TextAlign.center,
                                style: textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Silahkan masuk untuk melanjutkan",
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 48.0),

                              // Form Username
                              TextFormField(
                                controller: controller.usernameC,
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: "Username",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Username tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),

                              // Form Password
                              Obx(
                                () => TextFormField(
                                  controller: controller.passwordC,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => controller.login(),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    suffixIcon: Padding(
                                      padding: EdgeInsetsGeometry.only(
                                        right: paddingRightSuffixIcon,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: IconButton(
                                          icon: Icon(
                                            controller.isPasswordVisible.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: controller
                                              .togglePasswordVisibility,
                                        ),
                                      ),
                                    ),
                                    suffixIconColor: noFocused,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password tidak boleh kosong";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 32.0),

                              // Tombol Masuk
                              Obx(
                                () => controller.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          controller.login();
                                        },
                                        child: const Text(
                                          "MASUK",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
