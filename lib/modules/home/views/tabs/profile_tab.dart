// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/widgets/section_title.dart';
import 'package:salesforce_app/modules/home/controllers/profile_controller.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: mintGrean.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey[100],
                    child: Icon(
                      Icons.person,
                      size: 50.sp,
                      color: Colors.grey[400],
                    ),
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
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          SectionTitle(title: "Informasi Pribadi"),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                _buildProfileItem(
                  Icons.person_outline,
                  "Username",
                  controller.username.value,
                ),
                _buildDivider(),
                _buildProfileItem(
                  Icons.badge_outlined,
                  "NIP",
                  controller.nip.value,
                ),
                _buildDivider(),
                _buildProfileItem(
                  Icons.credit_card,
                  "No. KTP",
                  controller.noKtp.value,
                ),
                _buildDivider(),
                _buildProfileItem(
                  Icons.phone_android,
                  "No. Handphone",
                  controller.noHp.value,
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          SectionTitle(title: "Informasi Perangkat"),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
            decoration: _boxDecoration(),
            child: Column(
              children: [
                Obx(
                  () => _buildProfileItem(
                    Icons.info_outline,
                    "Versi Aplikasi",
                    controller.appVersion.value,
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildProfileItem(
                    Icons.phone_iphone,
                    "Device Model",
                    controller.deviceName.value,
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildProfileItem(
                    Icons.android,
                    "OS System",
                    controller.deviceOs.value,
                  ),
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
                foregroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              icon: const Icon(Icons.logout),
              label: Text(
                "Keluar Aplikasi",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: mintGrean.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.sp, color: primaryColor),
          ),
          SizedBox(width: 16.w),

          // Data
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[100], thickness: 1, height: 1);
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
