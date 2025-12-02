import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/modules/outlet/controllers/add_outlet_controller.dart';

class RegionSearchDialog extends StatelessWidget {
  final AddOutletController controller = Get.find();
  final TextEditingController searchInputC = TextEditingController();
  final showClearButton = false.obs;

  RegionSearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Reset query saat dialog dibuka agar list kembali penuh
    // Gunakan addPostFrameCallback agar aman
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchInputC.clear();
      controller.regionSearchQuery.value = '';
      controller.searchRegion(''); // Reset ke semua data
    });

    return Container(
      height: 0.85.sh,
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cari Area / Wilayah",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
                splashRadius: 24,
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Search Bar
          Obx(
            () => TextField(
              controller: searchInputC,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: (val) {
                controller.regionSearchQuery.value = val;
                showClearButton.value = val.isNotEmpty;
              },
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "Ketik Kelurahan / Kecamatan...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: showClearButton.value
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          searchInputC.clear();
                          controller.regionSearchQuery.value = "";
                          showClearButton.value = false;
                          // Trigger search kosong manual agar list balik
                          controller.searchRegion("");
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: primaryColor, width: 1),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Result List
          Expanded(
            child: Obx(() {
              if (controller.isSearchingRegion.value) {
                return const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }

              // Jika kosong, berarti HASIL FILTER 0 (Tidak Ketemu)
              // Karena default-nya sekarang list terisi semua data.
              if (controller.regionSearchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Wilayah tidak ditemukan",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Coba kata kunci lain",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // List Data
              return ListView.separated(
                itemCount: controller.regionSearchResults.length,
                separatorBuilder: (c, i) =>
                    Divider(height: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final region = controller.regionSearchResults[index];
                  return InkWell(
                    onTap: () => controller.selectRegion(region),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 4.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                region.kelurahan,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                width: 4.w,
                                height: 4.w,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                region.kecamatan,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "${region.kota}, ${region.provinsi}  •  ${region.kodePos}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
