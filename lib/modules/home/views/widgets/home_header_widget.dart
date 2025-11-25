import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart'; // Import warna tadi

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          // Profil
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bandit Zubair",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Magang",
                      style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              // Avatar Placeholder
              CircleAvatar(radius: 24.r, backgroundColor: Colors.grey[300]),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white24, thickness: 1),
          SizedBox(height: 16.h),

          // Info Pesanan
          Row(
            children: [
              _buildStatItem(
                "Pesanan bulan ini:",
                "Rp 55.000.000",
                Icons.account_balance_wallet,
              ),
              Container(
                height: 30.h,
                width: 1,
                color: Colors.white24,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              _buildStatItem(
                "Pesanan bulan ini:",
                "Rp 55.000.000",
                Icons.wallet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 10.sp),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 16.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
