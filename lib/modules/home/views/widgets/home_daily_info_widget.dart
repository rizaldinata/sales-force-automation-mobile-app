import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';

class HomeDailyInfo extends StatelessWidget {
  const HomeDailyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informasi harian",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KARTU KIRI (List Info)
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    _buildRowItem(
                      Icons.calendar_month,
                      "Jadwal kunjungan",
                      "Total jadwal kunjungan yang ada",
                      "5",
                    ),
                    SizedBox(height: 12.h),
                    _buildRowItem(
                      Icons.check_circle_outline,
                      "Kunjungan selesai",
                      "Total kunjungan yang telah dilakukan",
                      "5",
                    ),
                    SizedBox(height: 12.h),
                    _buildRowItem(
                      Icons.receipt_long,
                      "Banyak pesanan",
                      "Total jumlah pesanan yang ada",
                      "5",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // KARTU KANAN (Jam Masuk/Keluar)
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "Jam\nMasuk",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "07:28",
                      style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Divider(),
                    SizedBox(height: 8.h),
                    Text(
                      "Jam\nKeluar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "BELUM",
                      style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRowItem(
    IconData icon,
    String title,
    String subtitle,
    String value,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundColor: mintGrean,
          child: Icon(icon, size: 16.sp, color: Colors.black54),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                maxLines: 1,
              ),
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
