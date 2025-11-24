import 'package:get/get.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void logout() {
    tabIndex.value = 0;
    Get.offAllNamed(AppRoutes.login);
  }
}
