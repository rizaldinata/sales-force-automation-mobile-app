import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/data/models/menu_model.dart';
import 'package:salesforce_app/app/data/models/product_model.dart';
import 'package:salesforce_app/app/routes/app_routes.dart';
import 'package:salesforce_app/modules/home/controllers/profile_controller.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  late PageController pageController;

  bool _isAnimating = false;

  final menus = <MenuModel>[
    MenuModel(label: "Outlet", icon: Icons.store_mall_directory, actionCode: 3),
    MenuModel(label: "Presensi v2", icon: Icons.fingerprint),
    MenuModel(label: "Survey toko", icon: Icons.assignment_turned_in),
    MenuModel(label: "Pesanan", icon: Icons.shopping_cart),
    MenuModel(label: "Produk", icon: Icons.inventory_2),
    MenuModel(label: "Kunjungan v2", icon: Icons.location_on, actionCode: 1),
    MenuModel(label: "Plan kunjungan", icon: Icons.calendar_month),
    MenuModel(label: "Lain lain", icon: Icons.apps),
  ].obs;

  final products = <ProductModel>[
    ProductModel(
      name: "Sarung Atlas Idaman",
      variant: "555 Kembang",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung BHS Classic",
      variant: "Gold Motif",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung BHS Masterpiece",
      variant: "Hujan Gerimis",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung Atlas Idaman",
      variant: "555 Kembang",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung BHS Classic",
      variant: "Gold Motif",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung BHS Masterpiece",
      variant: "Hujan Gerimis",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung Atlas Idaman",
      variant: "555 Kembang",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung BHS Classic",
      variant: "Gold Motif",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
    ProductModel(
      name: "Sarung BHS Masterpiece",
      variant: "Hujan Gerimis",
      imageUrl:
          "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
    ),
  ].obs;

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
    if (index == 3) {
      Get.toNamed(AppRoutes.outlet);
      return;
    }

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
