// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';
import 'package:salesforce_app/modules/outlet/controllers/outlet_controller.dart';
import 'package:salesforce_app/modules/outlet/views/add_outlet_view.dart';
import 'package:salesforce_app/modules/outlet/views/widgets/outlet_card.dart';

class OutletView extends GetView<OutletController> {
  const OutletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: SizedBox(
        height: 50.h,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const AddOutletView());
          },
          backgroundColor: primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          icon: Icon(Icons.add, color: Colors.white, size: 20.sp),
          label: Text(
            "Tambah Outlet",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 24.w, 16.h),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 24.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: TextField(
                      controller: controller.searchC,
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: "Cari Outlet...",
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16.w,
                        ),
                        filled: true,
                        fillColor: backgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  InkWell(
                    onTap: controller.openFilter,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: Container(
                      height: 48.h,
                      width: 48.h,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(Icons.tune, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.displayedOutlets.isEmpty &&
                    controller.isLoadingMore.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 80.h),
                  itemCount:
                      controller.displayedOutlets.length +
                      (controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.displayedOutlets.length) {
                      return Padding(
                        padding: EdgeInsets.all(16.h),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      );
                    }
                    final outlet = controller.displayedOutlets[index];
                    return OutletCard(outlet: outlet, onTap: () {});
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
