import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageSwipe(int index) {
    tabIndex.value = index;
  }

  void logout() {
    tabIndex.value = 0;
    Get.offAllNamed(AppRoutes.login);
  }
}
