// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';
import 'package:salesforce_app/app/ui/widgets/primary_header_card.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>();

    const String photoUrl = "https://i.pravatar.cc/300";

    return PrimaryHeaderCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Magang",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 22.r,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: const CachedNetworkImageProvider(photoUrl),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Divider(
            color: Colors.white.withOpacity(0.2),
            thickness: 1,
            height: 1,
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              _buildStatItem(
                "Pesanan bulan ini:",
                "Rp 55.000.000",
                Icons.account_balance_wallet,
              ),

              Container(
                height: 24.h,
                width: 1,
                color: Colors.white.withOpacity(0.2),
                margin: EdgeInsets.symmetric(horizontal: 12.w),
              ),

              _buildStatItem("Performance:", "95%", Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 8.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 10.sp,
                    height: 1.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
