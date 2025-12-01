// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';
import 'package:salesforce_app/app/ui/widgets/custom_radio_field.dart';
import 'package:salesforce_app/modules/outlet/controllers/outlet_controller.dart';

class OutletFilterSheet extends GetView<OutletController> {
  const OutletFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Outlet",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: controller.resetFilter,
                child: Text(
                  "Reset",
                  style: TextStyle(fontSize: 14.sp, color: Colors.red),
                ),
              ),
            ],
          ),
          Divider(thickness: 1, color: Colors.grey[200]),

          SizedBox(height: 16.h),

          Obx(
            () => CustomRadioField(
              label: "Status Outlet",
              items: controller.statusList,
              selectedValue: controller.selectedStatus.value,
              onChanged: (val) => controller.selectedStatus.value = val,
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            "Waktu Kunjungan",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),

          SizedBox(height: 12.h),

          Obx(
            () => Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                children: [
                  _buildTabItem(
                    "Per Bulan",
                    "period",
                    controller.filterDateMode.value,
                  ),
                  _buildTabItem(
                    "Rentang Tanggal",
                    "range",
                    controller.filterDateMode.value,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Obx(() {
            if (controller.filterDateMode.value == 'period') {
              // MODE PERIODE
              return _buildPeriodPicker(context);
            } else {
              // MODE RANGE
              return _buildRangePicker(context);
            }
          }),

          SizedBox(height: 32.h),

          SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: controller.applyFilter,
              style: ElevatedButton.styleFrom(),
              child: const Text("Terapkan Filter"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, String value, String groupValue) {
    bool isSelected = value == groupValue;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.filterDateMode.value = value,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.0),

            borderRadius: BorderRadius.circular(AppRadius.lg - 4),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? Colors.black.withOpacity(0.08)
                    : Colors.black.withOpacity(0.0),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: isSelected ? primaryColor : Colors.grey[500],
            ),
            child: Text(label, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodPicker(BuildContext context) {
    return InkWell(
      onTap: () => controller.pickMonth(),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: const Color(0xFFD9D9D9)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                DateFormat(
                  'MMMM yyyy',
                  'id_ID',
                ).format(controller.selectedMonth.value),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.calendar_month, color: primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildRangePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _dateInputBox(
            context,
            label: "Dari",
            value: controller.startDate.value,
            onTap: () => controller.pickDate(context, isStart: true),
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: _dateInputBox(
            context,
            label: "Sampai",
            value: controller.endDate.value,
            onTap: () => controller.pickDate(context, isStart: false),
          ),
        ),
      ],
    );
  }

  Widget _dateInputBox(
    BuildContext context, {
    required String label,
    DateTime? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: const Color(0xFFD9D9D9)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value != null ? DateFormat('dd/MM/yy').format(value) : label,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: value != null ? Colors.black87 : Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.calendar_month, size: 18.sp, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
