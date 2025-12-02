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
    // Reset query saat dialog dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchInputC.clear();
      controller.regionSearchQuery.value = '';
      controller.searchRegion('');
    });

    return Container(
      height: 0.85.sh,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // --- PERBAIKAN DI SINI ---
      // Bungkus isi dengan SafeArea atau Padding Top manual
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          16.h,
          20.w,
          0,
        ), // Padding Top 16.h cukup aman
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cari Area / Wilayah",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                  splashRadius: 24,
                  // Agar tombol X tidak terlalu mepet kanan
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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

                return ListView.separated(
                  itemCount: controller.regionSearchResults.length,
                  padding: EdgeInsets.only(
                    bottom: 20.h,
                  ), // Padding bawah agar list tidak tertutup keyboard
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
      ),
    );
  }
}
