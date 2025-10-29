import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/premium_controller/premium_controller.dart';
import '../../../res/assets/image_assets.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/app_assets_image.dart';
import '../../../res/components/custom_rounded_button.dart';
import '../../../res/components/custom_text.dart';
import '../../../res/routes/routes_name.dart';

class SubscriptionPlanInfo extends StatelessWidget {
  const SubscriptionPlanInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PremiumController>(
      init: PremiumController(),
      builder: (controller) {
        final List<Map<String, String>> paymentMethods = [
          {
            'name': 'Easypaisa',
            'holder': 'Ahmed Khan',
            'number': '02143343434',
            'logo': ImageAssets.easyPaisa,
          },
          {
            'name': 'Jazz Cash',
            'holder': 'Ahmed Khan',
            'number': '02143343434',
            'logo': ImageAssets.jazzCash,
          },
          {
            'name': 'Bank Al Habib',
            'holder': 'Ahmed Khan',
            'number': '02143343434',
            'logo': ImageAssets.masterCard,
          },
        ];

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
            body: Obx(() {
              return Stack(
                children: [
                  // 🧩 Actual Page Content
                  Column(
                    children: [
                      CustomText(
                        title: "Subscription Plan Information",
                        fontcolor: AppColor.whiteColor,
                        fontsize: 20.sp,
                        fontweight: FontWeight.w700,
                      ),
                      SizedBox(height: 15.h),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
                              color: AppColor.whiteColor,
                            ),
                            padding: EdgeInsets.all(12.w),
                            child: Obx(() {
                              final bool anyImageSelected = controller.selectedImages.isNotEmpty;

                              return Column(
                                children: [
                                  ...paymentMethods.map((method) {
                                    final selectedImage = controller.selectedImages[method['name']];
                                    final bool isSelected = selectedImage != null;

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF4F0FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 24,
                                            child: AppAssetsImage(
                                              imagePath: method['logo']!,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          SizedBox(height: method['name'] == 'Bank Al Habib' ? 14.h : 0),
                                          Text(
                                            method['name']!,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Name : ${method['holder']}',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      method['name'] == 'Bank Al Habib'
                                                          ? 'Account Number : ${method['number']}'
                                                          : 'Number : ${method['number']}',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await controller.pickImageFromGallery(method['name']!);
                                                  if (controller.selectedImages[method['name']] != null) {
                                                    Get.snackbar(
                                                      "Image Selected",
                                                      "Screenshot uploaded for ${method['name']}",
                                                      backgroundColor: Colors.white,
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: isSelected ? Colors.green.shade100 : AppColor.whiteColor,
                                                    borderRadius: BorderRadius.circular(18.r),
                                                    border: Border.all(
                                                      color: isSelected ? Colors.green : AppColor.whiteColor4,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  padding: isSelected
                                                      ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
                                                      : EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      isSelected
                                                          ? ClipRRect(
                                                              borderRadius: BorderRadius.circular(12),
                                                              child: Image.file(
                                                                selectedImage,
                                                                width: 60.w,
                                                                height: 60.h,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            )
                                                          : AppAssetsImage(
                                                              imagePath: ImageAssets.uploadFile,
                                                              fit: BoxFit.scaleDown,
                                                              width: 30.w,
                                                              height: 30.h,
                                                            ),
                                                      if (!isSelected) ...[
                                                        SizedBox(height: 6.h),
                                                        CustomText(
                                                          title: "Upload\nScreenshot",
                                                          fontsize: 8,
                                                          textalign: TextAlign.center,
                                                          fontweight: FontWeight.w700,
                                                          fontcolor: AppColor.black121,
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  if (anyImageSelected)
                                    SafeArea(
                                      child: Container(
                                        color: AppColor.whiteColor,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 16, bottom: 5),
                                        child: CustomRoundButton(
                                          title: controller.isLoading.value ? "Processing..." : "Confirm Payment",
                                          onPress: () async {
                                            if (controller.isLoading.value) return;
                                            await controller.confirmPayment(
                                              context: context,
                                              paymentSource: controller.selectedImages.keys.first,
                                            );
                                            Get.toNamed(RouteName.paymentSuccessful);
                                          },
                                        ),
                                      ),
                                    )
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 🌀 Loading Overlay
                  if (controller.isLoading.value)
                    Container(
                      color: Colors.black.withOpacity(0.4),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
