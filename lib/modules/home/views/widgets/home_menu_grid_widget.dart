import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';

class HomeMenuGrid extends StatelessWidget {
  HomeMenuGrid({super.key});

  final List<Map<String, dynamic>> menus = [
    {"label": "Outlet", "icon": Icons.store},
    {"label": "Presensi v2", "icon": Icons.fingerprint},
    {"label": "Survey toko", "icon": Icons.list_alt},
    {"label": "Pesanan", "icon": Icons.shopping_cart},
    {"label": "Produk", "icon": Icons.inventory_2},
    {"label": "Kunjungan v2", "icon": Icons.location_on},
    {"label": "Plan kunjungan", "icon": Icons.map},
    {"label": "Lain lain", "icon": Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu fitur",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemCount: menus.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CircleAvatar(radius: 28.r, backgroundColor: mintGrean),
                SizedBox(height: 8.h),
                Text(
                  menus[index]['label'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
