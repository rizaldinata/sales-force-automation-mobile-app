import 'package:get/get.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';
import 'package:salesforce_app/modules/home/bindings/home_binding.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';
import 'package:salesforce_app/modules/home/views/home_view.dart';
import 'package:salesforce_app/modules/login/bindings/login_binding.dart';
import 'package:salesforce_app/modules/login/views/login_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ),
  ];
}
