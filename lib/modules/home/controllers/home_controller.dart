import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';
import 'package:salesforce_app/modules/home/controllers/profile_controller.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  late PageController pageController;

  bool _isAnimating = false;

  @override
  void onInit() {
    super.onInit();
    tabIndex.value = 0;
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) async {
    if (_isAnimating || tabIndex.value == index) return;

    _isAnimating = true;
    tabIndex.value = index;

    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );

    _isAnimating = false;
  }

  void onPageSwipe(int index) {
    if (!_isAnimating) {
      tabIndex.value = index;
    }
  }

  void logout() {
    tabIndex.value = 0;

    Get.delete<HomeController>(force: true);
    Get.delete<VisitController>(force: true);
    Get.delete<ProfileController>(force: true);
    Get.offAllNamed(AppRoutes.login);
  }
}
