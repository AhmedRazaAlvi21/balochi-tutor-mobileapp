import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../res/assets/custom_bubble_shape.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class PaymentSuccessful extends StatelessWidget {
  PaymentSuccessful({super.key});

  final Map? args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Utils.onwillPopFunc(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appPrimaryGradient1,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: context.blockSizeVertical * 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: AppColor.whiteColor),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.r),
                              child: CustomPaint(
                                painter: RPSCustomPainter(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 25.h,
                                    right: 50.w,
                                    left: 50.w,
                                    top: 10.h,
                                  ),
                                  child: CustomText(
                                    title: 'complete_payment_text1'.tr,
                                    fontcolor: AppColor.blackColor,
                                    fontsize: 18.sp,
                                    fontweight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            AppAssetsImage(
                              imagePath: ImageAssets.character,
                              fit: BoxFit.scaleDown,
                              height: 200.h,
                              width: 200.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: CustomText(
                                title: "payment_successful".tr,
                                fontcolor: AppColor.primaryColor,
                                textalign: TextAlign.center,
                                fontsize: 26.sp,
                                fontweight: FontWeight.w700,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 5.0,
                              ),
                              child: CustomText(
                                title:
                                    "You have successfully subscribed to Balochi Tutor for ${premiumController.monthPlan}. We will always remind you before the subscription expires. Enjoy the benefits.",
                                fontcolor: AppColor.blackColor,
                                textalign: TextAlign.left,
                                fontsize: 16.sp,
                                fontweight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColor.whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 16, bottom: 5),
                child: Obx(
                  () {
                    return CustomRoundButton(
                      title: loadingController.isLoading.value ? null : "${'oK_great'.tr}",
                      isLoading: loadingController.isLoading.value,
                      onPress: loadingController.isLoading.value
                          ? null
                          : () async {
                              Get.offAllNamed(RouteName.dashboardScreen);
                            },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
