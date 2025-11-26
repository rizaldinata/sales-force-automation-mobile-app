import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/widgets/floating_navbar.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';
import 'package:salesforce_app/app/ui/widgets/keep_alive_wrapper.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/visit_tab.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.onPageSwipe(index);

            if (index == 1) {
              Get.find<VisitController>().onTabOpened();
            }
          },
          children: const [
            KeepAliveWrapper(child: DashboardTab()),
            KeepAliveWrapper(child: VisitTab()),
            KeepAliveWrapper(child: ProfileTab()),
          ],
        ),
      ),

      bottomNavigationBar: Obx(
        () => FloatingNavBar(
          selectedIndex: controller.tabIndex.value,
          onTap: (index) {
            controller.changeTabIndex(index);
            if (index == 1) {
              Get.find<VisitController>().onTabOpened();
            }
          },
        ),
      ),
    );
  }
}
