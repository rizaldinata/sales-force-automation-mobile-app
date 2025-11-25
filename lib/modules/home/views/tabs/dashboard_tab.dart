// ignore_for_file: deprecated_member_use

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
    final List<Map<String, String>> products = [
      {
        "name": "Sarung Atlas Idaman",
        "variant": "555 Kembang",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung BHS Classic",
        "variant": "Gold Motif",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung BHS Masterpiece",
        "variant": "Hujan Gerimis",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung Atlas Idaman",
        "variant": "555 Kembang",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung BHS Classic",
        "variant": "Gold Motif",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung BHS Masterpiece",
        "variant": "Hujan Gerimis",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung Atlas Idaman",
        "variant": "555 Kembang",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung BHS Classic",
        "variant": "Gold Motif",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
      {
        "name": "Sarung BHS Masterpiece",
        "variant": "Hujan Gerimis",
        "image":
            "https://www.sarungbhs.co.id/bima-themes/www/bhs/bima-assets/new/images/sarungsignature.png",
      },
    ];

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
            height: 180.h,
            child: OverflowBox(
              maxWidth: 1.sw,
              minWidth: 1.sw,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: products.length,
                separatorBuilder: (c, i) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(
                    name: product["name"]!,
                    variant: product["variant"]!,
                    imageUrl: product["image"]!,
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 24.h),
          const HomeDailyInfo(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String name,
    required String variant,
    required String imageUrl,
  }) {
    return Container(
      width: 140.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10.w),
                color: mintGrean,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      variant,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
