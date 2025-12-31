import 'package:balochi_tutor/res/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/premium_controller/premium_controller.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/routes/routes_name.dart';

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PremiumController>(
      init: PremiumController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appPrimaryGradient1,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomText(
                        title: "Subscription plan Information",
                        fontcolor: AppColor.whiteColor,
                        fontsize: 20.sp,
                        fontweight: FontWeight.w700,
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        margin: EdgeInsets.all(16.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Choose a subscription plan",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Divider(),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.allPremiumPlanData.length,
                              itemBuilder: (context, index) {
                                var plan = controller.allPremiumPlanData[index];
                                bool isSelected = controller.planId.value == plan['id'];

                                return GestureDetector(
                                  onTap: () {
                                    controller.planId.value = plan['id'];
                                    controller.planPrice.value = plan['price'];
                                    controller.monthPlan.value = plan['duration'];
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColor.whiteColor5 : AppColor.whiteColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: isSelected ? AppColor.blueColor2 : AppColor.whiteColor4,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              plan['duration'],
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              plan['discount'],
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColor.black161,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          plan['price'],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                if (controller.planId.value > 0)
                  SafeArea(
                    child: Container(
                      color: AppColor.whiteColor,
                      padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 16, bottom: 5),
                      child: CustomRoundButton(
                        title: 'continue'.tr,
                        onPress: () {
                          Get.toNamed(RouteName.subscriptionPlanInfo);
                          Get.snackbar(
                            "Plan Selected",
                            "You selected ${controller.monthPlan.value} for ${controller.planPrice.value}",
                            backgroundColor: Colors.white,
                          );
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
