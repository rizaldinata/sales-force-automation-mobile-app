import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:salesforce_app/app/ui/widgets/primary_header_card.dart';
import 'package:salesforce_app/app/ui/widgets/custom_dropdown.dart';
import 'package:salesforce_app/app/ui/widgets/section_title.dart';

class VisitTab extends StatelessWidget {
  const VisitTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VisitController());
    String todayDate = DateFormat(
      'EEEE, d MMMM yyyy',
      'id_ID',
    ).format(DateTime.now());

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryHeaderCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Form Kunjungan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          todayDate,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                SizedBox(height: 16.h),

                // Waktu Datang & Pulang
                IntrinsicHeight(
                  child: Row(
                    children: [
                      _buildTimeInfo("Waktu Datang", controller.waktuDatang),

                      // Divider Tengah
                      Container(
                        height: 30.h,
                        width: 1,
                        color: Colors.white.withOpacity(0.2),
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                      ),

                      _buildTimeInfo("Waktu Pulang", controller.waktuPulang),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 28.h),
          const SectionTitle(
            title: "Titik Lokasi",
            subtitle: "Pastikan sesuai lokasi toko saat ini",
          ),

          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Obx(() {
                if (controller.isLoadingMap.value) {
                  return Container(
                    color: Colors.grey[50],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      controller.currentLat.value,
                      controller.currentLng.value,
                    ),
                    initialZoom: 16.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.salesforce.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            controller.currentLat.value,
                            controller.currentLng.value,
                          ),
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 48.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),

          SizedBox(height: 28.h),
          const SectionTitle(
            title: "Data Outlet",
            subtitle: "Pilih toko tujuan kunjungan",
          ),
          CustomDropdown(
            label: "Nama Outlet",
            hint: "Pilih Outlet",
            items: controller.outletList,
            selectedValue: controller.selectedOutlet,
            onChanged: (val) => controller.selectedOutlet.value = val,
            icon: Icons.store_mall_directory,
          ),
          SizedBox(height: 16.h),
          CustomDropdown(
            label: "Jenis Outlet",
            hint: "Pilih Jenis",
            items: controller.outletTypeList,
            selectedValue: controller.selectedOutletType,
            onChanged: (val) => controller.selectedOutletType.value = val,
            icon: Icons.category,
          ),
          SizedBox(height: 40.h),

          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: Obx(() {
              String buttonText = "Check In";
              Color buttonColor = primaryColor;
              bool isDisabled = false;
              IconData btnIcon = Icons.login;
              if (controller.visitStatus.value == 1) {
                buttonText = "Check Out";
                buttonColor = Colors.orange[800]!;
                btnIcon = Icons.logout;
              } else if (controller.visitStatus.value == 2) {
                buttonText = "Kunjungan Selesai";
                buttonColor = Colors.grey;
                btnIcon = Icons.check_circle;
                isDisabled = true;
              }
              return ElevatedButton.icon(
                onPressed: isDisabled ? null : controller.handleButtonAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[200],
                  disabledForegroundColor: Colors.grey[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: isDisabled ? 0 : 4,
                  shadowColor: buttonColor.withOpacity(0.4),
                ),
                icon: Icon(btnIcon),
                label: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  // --- HELPER WIDGET UPDATED ---
  Widget _buildTimeInfo(String label, RxString value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Obx(
            () => Text(
              value.value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
