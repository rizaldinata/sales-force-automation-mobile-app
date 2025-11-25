import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/home/controllers/profile_controller.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, size: 50.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => Text(
                    controller.nama.value,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.jabatan.value,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Data Pribadi
          _buildSectionHeader("Informasi Pribadi"),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                _buildInfoRow("Username", controller.username.value),
                _buildDivider(),
                _buildInfoRow("NIP", controller.nip.value),
                _buildDivider(),
                _buildInfoRow("No. KTP", controller.noKtp.value),
                _buildDivider(),
                _buildInfoRow("No. Handphone", controller.noHp.value),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Informasi Device
          _buildSectionHeader("Informasi Perangkat"),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                Obx(
                  () => _buildInfoRow(
                    "Versi Aplikasi",
                    controller.appVersion.value,
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildInfoRow(
                    "Device Model",
                    controller.deviceName.value,
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildInfoRow("OS System", controller.deviceOs.value),
                ),
                _buildDivider(),
                Obx(
                  () =>
                      _buildInfoRow("Product ID", controller.productType.value),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red, // Teks Merah
                padding: EdgeInsets.symmetric(vertical: 16.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Colors.red),
                ),
              ),
              icon: Icon(Icons.logout),
              label: Text(
                "Keluar Aplikasi",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SizedBox(height: 40.h), // Spacing bawah
        ],
      ),
    );
  }

  // --- HELPER WIDGETS (Biar kodingan rapi) ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[200], thickness: 1);
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );
  }
}
