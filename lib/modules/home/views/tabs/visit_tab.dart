import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';

class VisitTab extends StatelessWidget {
  const VisitTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VisitController());

    String todayDate = DateFormat(
      'EEEE, d MMMM yyyy',
      'id_ID',
    ).format(DateTime.now());

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0D5D37),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Form\nkunjungan pelanggan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          todayDate,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(color: Colors.white30, thickness: 1),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    _buildTimeInfo("Waktu Datang", controller.waktuDatang),
                    Container(height: 30.h, width: 1, color: Colors.white30),
                    _buildTimeInfo("Waktu Pulang", controller.waktuPulang),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            "Titik lokasi",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Pastikan lokasi sesuai dengan lokasi anda saat ini",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 12.h),

          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.grey[300],
              image: const DecorationImage(
                image: NetworkImage(
                  "https://img.freepik.com/free-vector/city-map-navigation-interface_23-2148494957.jpg",
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(Icons.location_on, color: Colors.red, size: 40.sp),
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            "Outlet",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          _buildDropdown(
            hint: "Pilih pada dropdown",
            items: controller.outletList,
            onChanged: (val) => controller.selectedOutlet.value = val,
            selectedValue: controller.selectedOutlet,
          ),

          SizedBox(height: 16.h),

          Text(
            "Jenis Outlet",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          _buildDropdown(
            hint: "Pilih pada dropdown",
            items: controller.outletTypeList,
            onChanged: (val) => controller.selectedOutletType.value = val,
            selectedValue: controller.selectedOutletType,
          ),

          SizedBox(height: 40.h),

          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: Obx(() {
              String buttonText = "Check In";
              Color buttonColor = const Color(0xFF0D5D37);
              bool isDisabled = false;

              if (controller.visitStatus.value == 1) {
                buttonText = "Check Out (Selesai)";
                buttonColor = Colors.orange[800]!;
              } else if (controller.visitStatus.value == 2) {
                buttonText = "Kunjungan Selesai";
                buttonColor = Colors.grey;
                isDisabled = true;
              }

              return ElevatedButton(
                onPressed: isDisabled ? null : controller.handleButtonAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  disabledForegroundColor: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String label, RxString value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Obx(
            () => Text(
              value.value,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
    required Rxn<String> selectedValue,
  }) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F3),
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: Colors.transparent),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue.value,
            hint: Text(
              hint,
              style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
            ),
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
            borderRadius: BorderRadius.circular(16.r),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 14.sp)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
