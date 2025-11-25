import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';

class HomeMenuGrid extends StatelessWidget {
  HomeMenuGrid({super.key});

  final List<Map<String, dynamic>> menus = [
    {"label": "Outlet", "icon": Icons.store_mall_directory, "action": null},
    {"label": "Presensi v2", "icon": Icons.fingerprint, "action": null},
    {
      "label": "Survey toko",
      "icon": Icons.assignment_turned_in,
      "action": null,
    },
    {"label": "Pesanan", "icon": Icons.shopping_cart, "action": null},
    {"label": "Produk", "icon": Icons.inventory_2, "action": null},
    {"label": "Kunjungan v2", "icon": Icons.location_on, "action": 1},
    {"label": "Plan kunjungan", "icon": Icons.calendar_month, "action": null},
    {"label": "Lain lain", "icon": Icons.apps, "action": null},
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
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: mintGrean,
                  child: Icon(
                    menus[index]['icon'],
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
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
