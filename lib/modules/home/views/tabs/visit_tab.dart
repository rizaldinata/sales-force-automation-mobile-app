import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
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
                            fontSize: 12.sp,
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
                IntrinsicHeight(
                  child: Row(
                    children: [
                      _buildTimeInfo("Waktu Datang", controller.waktuDatang),
                      VerticalDivider(
                        color: Colors.white.withOpacity(0.2),
                        thickness: 1,
                        width: 32.w,
                      ),
                      _buildTimeInfo("Waktu Pulang", controller.waktuPulang),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 28.h),

          _buildSectionHeader(
            "Titik Lokasi",
            "Pastikan sesuai lokasi toko saat ini",
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

          _buildSectionHeader("Data Outlet", "Pilih toko tujuan kunjungan"),

          _buildDropdown(
            label: "Nama Outlet",
            hint: "Pilih Outlet",
            items: controller.outletList,
            selectedValue: controller.selectedOutlet,
            onChanged: (val) => controller.selectedOutlet.value = val,
            icon: Icons.store_mall_directory,
          ),

          SizedBox(height: 16.h),

          _buildDropdown(
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

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildTimeInfo(String label, RxString value) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Obx(
            () => Text(
              value.value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required List<String> items,
    required Rxn<String> selectedValue,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue.value,
                hint: Row(
                  children: [
                    Icon(icon, size: 18.sp, color: Colors.grey[400]),
                    SizedBox(width: 12.w),
                    Text(
                      hint,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: primaryColor),
                borderRadius: BorderRadius.circular(16.r),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
