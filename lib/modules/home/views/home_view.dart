import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';
import 'tabs/dashboard_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              // Tab Dashboard
              const DashboardTab(),

              // Tab Kunjungan
              Center(
                child: Text(
                  "Halaman Kunjungan",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),

              // Tab Profil
              Center(
                child: Text(
                  "Halaman Profil",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Navbar
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_filled,
                index: 0,
                controller: controller,
              ),
              _buildNavItem(
                icon: Icons.flight_takeoff,
                index: 1,
                controller: controller,
              ),
              _buildNavItem(
                icon: Icons.account_circle,
                index: 2,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget
  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required HomeController controller,
  }) {
    bool isSelected = controller.tabIndex.value == index;
    return IconButton(
      onPressed: () => controller.changeTabIndex(index),
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
        size: 32.sp,
      ),
    );
  }
}
