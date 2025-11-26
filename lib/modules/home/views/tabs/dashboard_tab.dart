// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/widgets/product_card.dart';
import 'package:salesforce_app/app/ui/widgets/section_title.dart';
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

          const SectionTitle(title: "Produk terbaru"),

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
                  return ProductCard(
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
}
