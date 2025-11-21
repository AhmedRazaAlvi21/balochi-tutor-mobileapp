import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/app_assets_image.dart';
import '../../res/components/background_widget.dart';
import '../../utils/utils.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final controller = Get.find<DashboardController>();
        if (controller.currentIndex == 0) {
          return Utils.onwillPopFunc(context);
        } else {
          controller.onTabTapped(0);
          return false;
        }
      },
      child: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return BackgroundWidget(
              // painter: LanguageLearningBackgroundPainter(),
              child: Scaffold(
                //backgroundColor: AppColor.primaryColor,
                body: controller.children[controller.currentIndex],
                bottomNavigationBar: SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(top: 5.h),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColor.primary1,
                            AppColor.primary2,
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
                    child: BottomNavigationBar(
                      onTap: controller.onTabTapped,
                      currentIndex: controller.currentIndex,
                      backgroundColor: Colors.transparent,
                      // Must be transparent
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: AppColor.whiteColor,
                      unselectedItemColor: AppColor.whiteColor3,
                      elevation: 0,
                      unselectedLabelStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor3,
                        fontSize: 12 * context.textScaleFactorResponsive,
                      ),
                      selectedLabelStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        color: AppColor.whiteColor3,
                        fontSize: 12 * context.textScaleFactorResponsive,
                      ),
                      items: [
                        BottomNavigationBarItem(
                          icon: AppAssetsImage(
                            imagePath: ImageAssets.home1,
                            fit: BoxFit.scaleDown,
                            color: AppColor.whiteColor3,
                            width: 30.w,
                            height: 30.h,
                          ),
                          activeIcon: AppAssetsImage(
                            imagePath: ImageAssets.home,
                            fit: BoxFit.scaleDown,
                            color: AppColor.whiteColor,
                            width: 30.w,
                            height: 30.h,
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: AppAssetsImage(
                            imagePath: ImageAssets.course1,
                            fit: BoxFit.scaleDown,
                            color: AppColor.whiteColor3,
                            width: 30.w,
                            height: 30.h,
                          ),
                          activeIcon: AppAssetsImage(
                            imagePath: ImageAssets.course,
                            fit: BoxFit.scaleDown,
                            color: AppColor.whiteColor,
                            width: 30.w,
                            height: 30.h,
                          ),
                          label: 'Course',
                        ),
                        BottomNavigationBarItem(
                          icon: AppAssetsImage(
                            imagePath: ImageAssets.setting1,
                            fit: BoxFit.scaleDown,
                            color: AppColor.whiteColor3,
                            width: 30.w,
                            height: 30.h,
                          ),
                          activeIcon: AppAssetsImage(
                            imagePath: ImageAssets.setting,
                            fit: BoxFit.scaleDown,
                            color: AppColor.whiteColor,
                            width: 30.w,
                            height: 30.h,
                          ),
                          label: 'Settings',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
