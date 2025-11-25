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
              _buildStatRow(
                icon: Icons.calendar_month,
                title: "Jadwal kunjungan",
                subtitle: "Total jadwal kunjungan yang ada",
                value: "5",
              ),
              _buildDivider(),
              _buildStatRow(
                icon: Icons.check_circle_outline,
                title: "Kunjungan selesai",
                subtitle: "Total kunjungan yang telah dilakukan",
                value: "3",
              ),
              _buildDivider(),
              _buildStatRow(
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

  Widget _buildStatRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: mintGrean.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20.sp, color: Colors.black54),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: primaryColor,
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
