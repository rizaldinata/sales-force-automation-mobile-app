import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/home/views/widgets/home_daily_info_widget.dart';
import 'package:salesforce_app/modules/home/views/widgets/home_menu_grid_widget.dart';
import 'package:salesforce_app/modules/home/views/widgets/home_header_widget.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeaderWidget(),
          SizedBox(height: 24.h),
          HomeMenuGrid(),
          SizedBox(height: 24.h),

          Text(
            "Produk terbaru",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (c, i) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                return Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 24.h),
          const HomeDailyInfo(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
