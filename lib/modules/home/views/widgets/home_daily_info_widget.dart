import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/widgets/section_title.dart';
import 'package:salesforce_app/modules/home/views/widgets/statistic_item_widget.dart';

class HomeDailyInfo extends StatelessWidget {
  const HomeDailyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Informasi harian"),

        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
          decoration: _boxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAttendanceItem("Jam Masuk", "07:28", primaryColor),
              Container(height: 40.h, width: 1.w, color: Colors.grey[300]),
              _buildAttendanceItem("Jam Keluar", "--:--", Colors.grey),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          padding: EdgeInsets.all(20.w),
          decoration: _boxDecoration(),
          child: Column(
            children: [
              const StatisticItemWidget(
                icon: Icons.calendar_month,
                title: "Jadwal kunjungan",
                subtitle: "Total jadwal kunjungan yang ada",
                value: "5",
              ),
              _buildDivider(),
              const StatisticItemWidget(
                icon: Icons.check_circle_outline,
                title: "Kunjungan selesai",
                subtitle: "Total kunjungan yang telah dilakukan",
                value: "3",
              ),
              _buildDivider(),
              const StatisticItemWidget(
                icon: Icons.receipt_long,
                title: "Banyak pesanan",
                subtitle: "Total jumlah pesanan yang ada",
                value: "12",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceItem(String label, String time, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_filled,
              size: 16.sp,
              color: Colors.grey[400],
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          time,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: color == Colors.grey ? Colors.grey[400] : primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(color: Colors.grey[200], thickness: 1),
    );
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
