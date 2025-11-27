import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/widgets/section_title.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';

class HomeMenuGrid extends GetView<HomeController> {
  const HomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Menu fitur"),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.menus.length,
            itemBuilder: (context, index) {
              final menu = controller.menus[index];
              return InkWell(
                onTap: () {
                  if (menu.actionCode == 1) {
                    controller.changeTabIndex(1);
                  }
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: mintGrean,
                      child: Icon(menu.icon, color: Colors.white, size: 28.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      menu.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
