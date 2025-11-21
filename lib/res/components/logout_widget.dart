import 'package:balochi_tutor/res/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../colors/app_color.dart';
import 'custom_divider.dart';
import 'custom_text.dart';

class LogoutWidget extends StatelessWidget {
  final VoidCallback yesOntap;

  const LogoutWidget({super.key, required this.yesOntap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(35.0),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: 'Logout',
              fontcolor: AppColor.redColor,
              textalign: TextAlign.left,
              fontsize: 24,
              fontweight: FontWeight.w600,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: CustomDivider(),
            ),
            CustomText(
              title: 'Are you sure you want to log out?',
              fontcolor: AppColor.blackColor,
              textalign: TextAlign.left,
              fontsize: 20,
              fontweight: FontWeight.w500,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RoundButton(
                    buttonColor: Color(0xffF0EDFF),
                    text: CustomText(
                      title: 'cancel'.tr.toUpperCase(),
                      fontcolor: AppColor.primaryColor,
                      textalign: TextAlign.center,
                      fontsize: 14,
                      fontweight: FontWeight.w600,
                    ),
                    onPress: () {
                      Get.back();
                      // Get.toNamed(RouteName.ShareScreen);
                      // log('get started');
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: RoundButton(
                    text: CustomText(
                      title: 'Yes, Logout',
                      fontcolor: AppColor.primaryTextColor,
                      textalign: TextAlign.center,
                      fontsize: 14,
                      fontweight: FontWeight.w600,
                    ),
                    onPress: yesOntap,
                    boxshadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
