import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';

class CustomRadioField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final Function(String) onChanged;

  const CustomRadioField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. LABEL
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),

        // 2. OPSI KOTAK (Menggunakan Wrap agar responsif)
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 12.w, // Jarak Horizontal antar kotak
            runSpacing: 12.h, // Jarak Vertikal jika turun ke bawah
            children: items.map((item) {
              final isSelected = selectedValue == item;

              // Hitung lebar agar pas 2 kolom (Setengah layar dikurangi jarak)
              // (Layar - Padding Kiri Kanan - Spacing Tengah) / 2
              final double boxWidth = (1.sw - 48.w - 12.w) / 2;

              return InkWell(
                onTap: () => onChanged(item),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Container(
                  width: boxWidth, // Lebar dinamis (2 kolom)
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryColor.withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(
                      color: isSelected
                          ? primaryColor
                          : const Color(0xFFD9D9D9),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon kita kecilkan sedikit agar teks panjang muat
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected ? primaryColor : Colors.grey[400],
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),

                      // Gunakan Flexible agar teks bisa menyesuaikan jika sangat panjang
                      Flexible(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize:
                                13.sp, // Turunkan sedikit (14->13) agar aman
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected ? primaryColor : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
